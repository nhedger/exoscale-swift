# Exoscale API update — September 12, 2026

## Baseline and sources

The previous project edit was commit `7349a67` on **April 29, 2026**.
This update reviews the published API changelog after that date and implements
the current schemas, including subsequent corrections to newly introduced APIs.

- [Official API documentation](https://openapi-v2.exoscale.com/)
- [Official changelog](https://openapi-v2.exoscale.com/changes), including
  [page 2](https://openapi-v2.exoscale.com/changes?page=2) and
  [page 3](https://openapi-v2.exoscale.com/changes?page=3), which reaches the baseline
- [Current OpenAPI JSON](https://openapi-v2.exoscale.com/source.json)

At review time, the documentation's latest structural update was **August 4,
2026** (the changelog page's overall last-update label was September 4).
The downloaded JSON had SHA-256:

```text
63da6f74c845fd05467d43776d169f3d01c5137fb42e492b8c437573817038f5
```

## New endpoints: 35 operations

### VPC networking — 16 operations (beta)

Introduced June 9–30; implemented with the latest July subnet attachment fields.

| Method | API path | Swift resource method |
| --- | --- | --- |
| GET | `/vpc` | `vpcs.list()` |
| POST | `/vpc` | `vpcs.create(...)` |
| GET | `/vpc/{id}` | `vpcs.get(id:)` |
| PUT | `/vpc/{id}` | `vpcs.update(...)` |
| DELETE | `/vpc/{id}` | `vpcs.delete(id:)` |
| GET | `/vpc/{vpc-id}/route` | `vpcs.routes(vpcID:)` |
| GET | `/vpc/{vpc-id}/subnet` | `vpcs.subnets(vpcID:).list()` |
| POST | `/vpc/{vpc-id}/subnet` | `vpcs.subnets(vpcID:).create(...)` |
| GET | `/vpc/{vpc-id}/subnet/{id}` | `vpcs.subnets(vpcID:).get(id:)` |
| PUT | `/vpc/{vpc-id}/subnet/{id}` | `vpcs.subnets(vpcID:).update(...)` |
| DELETE | `/vpc/{vpc-id}/subnet/{id}` | `vpcs.subnets(vpcID:).delete(id:)` |
| PUT | `/vpc/{vpc-id}/subnet/{subnet-id}/attach` | `subnets.attachInstance(...)` |
| PUT | `/vpc/{vpc-id}/subnet/{subnet-id}/detach` | `subnets.detachInstance(...)` |
| GET | `/vpc/{vpc-id}/subnet/{subnet-id}/route` | `subnets.routes(subnetID:).list()` |
| POST | `/vpc/{vpc-id}/subnet/{subnet-id}/route` | `subnets.routes(subnetID:).create(...)` |
| DELETE | `/vpc/{vpc-id}/subnet/{subnet-id}/route/{id}` | `subnets.routes(subnetID:).delete(id:)` |

VPC/subnet creation and instance attachment return asynchronous operations.
Updates return resource details, route creation returns a route, and deletion
returns `Void` after decoding the API's empty JSON object. Subnet creation sends
the currently supported `addressfamily: inet4` and `address-space: private`.
Attachment supports a requested IPv4 address; subnet details expose attached instances.

### DBaaS ClickHouse — 14 operations (beta)

Introduced July 1, with role management added August 3.

| Method | API path | `dbaas.clickhouse` method |
| --- | --- | --- |
| GET | `/dbaas-clickhouse/{name}` | `get(name:)` |
| POST | `/dbaas-clickhouse/{name}` | `create(...)` |
| PUT | `/dbaas-clickhouse/{name}` | `update(...)` |
| DELETE | `/dbaas-clickhouse/{name}` | `delete(name:)` |
| PUT | `/dbaas-clickhouse/{name}/maintenance/start` | `startMaintenance(name:)` |
| GET | `/dbaas-settings-clickhouse` | `settings()` |
| GET | `/dbaas-clickhouse/{service-name}/user` | `listUsers(serviceName:)` |
| POST | `/dbaas-clickhouse/{service-name}/user` | `createUser(...)` |
| DELETE | `/dbaas-clickhouse/{service-name}/user/{user-uuid}` | `deleteUser(serviceName:userUUID:)` |
| PUT | `/dbaas-clickhouse/{service-name}/user/{username}/password/reset` | `resetUserPassword(...)` |
| GET | `/dbaas-clickhouse/{service-name}/user/{username}/password/reveal` | `revealUserPassword(...)` |
| GET | `/dbaas-clickhouse/{service-name}/acl-config` | `aclConfig(serviceName:)` |
| GET | `/dbaas-clickhouse/{service-name}/role` | `listRoles(serviceName:)` |
| DELETE | `/dbaas-clickhouse/{service-name}/role/{role-uuid}` | `deleteRole(serviceName:roleUUID:)` |

User creation and password reset return credentials directly, reflecting the
July 8 correction. User deletion uses a UUID, reflecting the July 22 correction.
Settings dictionaries support the latest `tiered_storage_move_factor` setting.

### AI, organization and SKS — 5 operations

| Method | API path | Swift resource method |
| --- | --- | --- |
| GET | `/ai/api-key/{id}/reveal` | `ai.apiKeys.reveal(id:)` |
| GET | `/ai/quota` | `ai.consumptionQuota()` |
| GET | `/live-balance` | `organization.liveBalance()` |
| PUT | `/sks-cluster/{id}/generate-karpenter-nodepool` | `sks.clusters.generateKarpenterNodepool(id:)` |
| PUT | `/sks-cluster/{id}/generate-karpenter-exoscale-nodeclass` | `sks.clusters.generateKarpenterExoscaleNodeclass(id:)` |

AI quota uses `quota-uom-per-minute`, including `null` for unlimited consumption.
Karpenter methods return the manifest string from the JSON response.

## Updates to existing operations and models

- **AI:** all six existing AI key operations now use `/ai/api-key` instead of
  `/ai/ai-api-key`. Rotation decodes the value-only response. Creation still
  returns metadata and the plaintext value, as restored July 10. Deployment
  creation accepts `productName` and a model reference by ID or name. Deployment
  responses expose `visibility` and retain optional fields for shared deployments.
  Model listing no longer sends the removed visibility filter; deployment listing
  retains its supported filter.
- **IAM:** assume-role policies have their own `IAMAssumeRolePolicy` type with a
  top-level `rules` array. Updating that policy uses `PUT /iam-role/{id}` with an
  `assume-role-policy` property; the removed `:assume-role-policy` endpoint is no
  longer called. Assuming a role requires a TTL and exposes `expiresAt`.
- **KMS:** creation allows omission of description, usage and multi-zone flags.
  Scheduling deletion reads `delete-at` instead of `status`; keys expose `deleteAt`.
  The existing optional description/replicas fields and `automatic` rotation
  fields already match the current schema, including the reverted July 22 rename.
- **SKS:** nodepool creation, updates and responses support NVIDIA MIG profiles
  for A30, RTX Pro 6000 and B300. B300 uses the corrected `b300.269gb` key, not the
  short-lived `b300.280gb` key. Cluster responses expose OIDC configuration.
- **Compute/storage:** instances expose `diskEncrypted`, volumes expose
  `encrypted`, and the instance type family includes `gpub300`. Snapshot decoding
  continues to use the instance model, including optional nested references.
- **DBaaS:** PostgreSQL creation, updates and responses expose `pgauditSettings`;
  MySQL updates accept `version` and responses expose `binlogRetentionPeriod`;
  Valkey creation and updates accept `version`. Existing settings dictionaries
  already support Valkey's `frequent_snapshots` and `active_expire_effort`.
- **Organization:** the API deprecates the organization response's `balance`;
  use `organization.liveBalance()` for the current balance.

The transient instance-pool `error-reason` addition was removed upstream, so it
does not require a model field. AI/KMS error schema changes remain compatible
with the client's status-based error handling.

## Source migration notes

These changes follow upstream breaking changes:

1. `ai.apiKeys.rotate(id:)` returns a plaintext `String`, rather than
   `AIAPIKeyWithValue`.
2. `kms.keys.scheduleDeletion(id:delayDays:)` returns the deletion timestamp as
   a Foundation `Date`, rather than `KMSKey.ActionStatus`.
3. Pass `ttl:` explicitly to `iam.roles.assume(targetRoleID:ttl:)`.
4. Use `IAMAssumeRolePolicy(rules: ...)` for assume-role policies. Ordinary role
   and organization policies continue to use `IAMPolicy`.
5. Replace `ai.models.list(visibility: ...)` with `ai.models.list()`.
6. Response timestamp properties now use `Date` / `Date?` instead of strings.
   This covers creation/update dates, KMS material/rotation/deletion dates, IAM
   credential expiry, AI log timestamps, audit events, DBaaS backup/task/maintenance
   timestamps and Kafka certificate expiry. Optional fields retain their optionality.

### Working with timestamps

The HTTP client automatically decodes ISO 8601 timestamps, accepting whole seconds,
fractional seconds and timezone offsets. Invalid timestamps throw a decoding error.
Use `Date` comparisons and Foundation formatting rather than string comparisons:

```swift
import Foundation

let deletionDate: Date = try await exoscale.kms.keys.scheduleDeletion(id: keyID)
let secondsUntilDeletion = deletionDate.timeIntervalSinceNow
let displayTimestamp = ISO8601DateFormatter().string(from: deletionDate)
```

For manually decoding API payloads or encoding SDK models, use the same configuration:

```swift
let key = try Exoscale.jsonDecoder().decode(Exoscale.KMSKey.self, from: data)
let encoded = try Exoscale.jsonEncoder().encode(key)
```

The encoder writes UTC ISO 8601 strings with fractional seconds. Plain
`JSONDecoder()` / `JSONEncoder()` use Foundation's numeric date representation by
default and are not appropriate for these API timestamps. Time-of-day maintenance
windows, durations, request date strings and unformatted DBaaS log time strings
retain their existing types.

## Verification

`Tests/ExoscaleTests/APIUpdateTests.swift` covers all 35 new operations and the
changed request/response contracts through an intercepted URLSession. Requests
still go through the real encoding, signing and decoding stack; tests do not
contact a live Exoscale account. Existing IAM fixtures were updated to the new
policy schema. Additional fixtures cover encryption flags, sparse deployments,
database settings, KMS deletion dates and current MIG profile names.

On a Mac whose selected Command Line Tools lack Swift Testing, use the installed
Xcode toolchain for the test run:

```bash
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer swift test
```
