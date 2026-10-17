#!/usr/bin/env bash
# Selects an installed Xcode that has Swift $1 (such as 6.2), for later steps on a macOS runner.
# Keeps the default Xcode when it has that version, and otherwise picks the newest stable Xcode
# that does. An Xcode's own toolchain matches its SDK, which an older compiler may not be able
# to read, and is the only one xcodebuild uses.
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

echo "No installed Xcode has Swift ${version}."
