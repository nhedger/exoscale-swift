func serializeLabels(_ labels: [String: String]?) -> String? {
    guard let labels, !labels.isEmpty else {
        return nil
    }

    return labels
        .map { "\($0.key):\($0.value)" }
        .sorted()
        .joined(separator: ",")
}
