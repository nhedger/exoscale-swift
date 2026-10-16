#!/usr/bin/env bash
# Makes Swift $1 (such as 6.2) the active toolchain on a macOS runner, for later steps.
# Uses the default Xcode when it has that version, then the newest stable Xcode that has it,
# and only installs it with swiftly when no Xcode has it: a swiftly toolchain still builds
# against an Xcode SDK, which an older compiler may not be able to read.
set -euo pipefail

version="$1"
pattern="Swift version ${version//./\\.}([. ]|$)"

has_version() {
  local output
  output=$("$1" --version 2>&1) || return 1
  grep -qE "$pattern" <<<"$output"
}

if has_version "$(xcrun --find swift)"; then
  echo "The default Xcode has Swift ${version}."
  exit 0
fi

while IFS= read -r xcode; do
  if has_version "$xcode/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift"; then
    echo "Using $xcode, which has Swift ${version}."
    echo "DEVELOPER_DIR=$xcode/Contents/Developer" >>"$GITHUB_ENV"
    exit 0
  fi
done < <(find /Applications -maxdepth 1 -type d -name 'Xcode*.app' \
  ! -iname '*beta*' ! -iname '*release_candidate*' | sort -rV)

echo "No installed Xcode has Swift ${version}, so installing it with swiftly."

export SWIFTLY_HOME_DIR="$RUNNER_TEMP/swiftly"
export SWIFTLY_BIN_DIR="$SWIFTLY_HOME_DIR/bin"
# xcrun and xcodebuild only find toolchains selected through TOOLCHAINS in this directory.
export SWIFTLY_TOOLCHAINS_DIR="$HOME/Library/Developer/Toolchains"
mkdir -p "$SWIFTLY_HOME_DIR"
# Run swiftly outside the checkout, so a .swift-version file there can't change its choice.
cd "$SWIFTLY_HOME_DIR"

curl -fsSL -o "$RUNNER_TEMP/swiftly.pkg" https://download.swift.org/swiftly/darwin/swiftly.pkg
pkgutil --check-signature "$RUNNER_TEMP/swiftly.pkg"
pkgutil --expand-full "$RUNNER_TEMP/swiftly.pkg" "$RUNNER_TEMP/swiftly-pkg"
bootstrap=$(find "$RUNNER_TEMP/swiftly-pkg" -type f -name swiftly | head -n 1)
"$bootstrap" init --assume-yes --skip-install --no-modify-profile --quiet-shell-followup

swiftly="$SWIFTLY_BIN_DIR/swiftly"
"$swiftly" install "$version" --assume-yes --post-install-file "$RUNNER_TEMP/swiftly-post-install.sh"
"$swiftly" use "$version" --global-default --assume-yes
toolchain=$("$swiftly" use --global-default --print-location)

echo "$toolchain/usr/bin" >>"$GITHUB_PATH"
echo "TOOLCHAINS=$(/usr/bin/plutil -extract CFBundleIdentifier raw "$toolchain/Info.plist")" >>"$GITHUB_ENV"
