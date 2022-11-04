# Advanced Configuration`

When consuming the Moonsense iOS Core SDK via Swift Package Manager, the `MOONSENSE_INCLUDE_CORE_PACKAGES` environment variable needs to be set. When this environment variable exists and is set to `YES` the Core SDK artifacts are included in the `Package.swift` resolution. If the variable is set and your `REPO_ACCESS_TOKEN` does not have the proper entitlements, the entire Swift Package resolution will fail.

## Setting `MOONSENSE_INCLUDE_CORE_PACKAGES` Globally

The easiest way to set the `MOONSENSE_INCLUDE_CORE_PACKAGES` environment variable is with `launchctl`.

1. Copy the [`setenv.MOONSENSE_INCLUDE_CORE_PACKAGES.plist`](setenv.MOONSENSE_INCLUDE_CORE_PACKAGES.plist) file to `~/Library/LaunchAgents`
2. Run the following command: `launchctl load -w ~/Library/LaunchAgents/setenv.MOONSENSE_INCLUDE_CORE_PACKAGES.plist`
3. Restart Xcode

