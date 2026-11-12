# LoggerKit

A lightweight, Swift 6 concurrency-safe logging framework for Apple platforms (iOS, macOS, Mac Catalyst, tvOS, visionOS, watchOS). Features actor-isolated console and file logging, 6 severity levels, simple/detailed formatting, custom log sections, and built-in log export and sharing.

## Requirements

- Swift 6.0+
- iOS 15.0+ / macOS 15.0+ / Mac Catalyst 15.0+ / tvOS 15.0+ / visionOS 1.0+ / watchOS 9.0+

## Installation

### Xcode
1. Open your project in Xcode.
2. Go to **File → Add Package Dependencies…**
3. Enter the repository URL:
   ```
   https://github.com/vb13/loggerkit.git
   ```
4. Select **Up to Next Major Version** from `1.0.0` and add **LoggerKit** to your target.

### `Package.swift`
Add `LoggerKit` to your `dependencies` and target dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/vb13/loggerkit.git", from: "1.0.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "LoggerKit", package: "loggerkit")
        ]
    )
]
```

## Quick Start

Import `LoggerKit` and start logging immediately (console logging with `.simple` style is enabled by default):

```swift
import LoggerKit

Logger.verbose("View loaded")
Logger.debug("Fetching user profile")
Logger.info("User logged in successfully")
Logger.warning("Location permission denied")
Logger.error("API request failed")
Logger.fatal("Database corruption detected")
```

## Configuration

Configure `LoggerKit` once at app startup:

```swift
import LoggerKit

var config = LoggerConfiguration()
config.outputStyle = .detailed       // .simple (default) or .detailed
config.enableFileLog = true          // false by default
config.minimumLogLevel = .debug      // .verbose by default

Logger.configure(config)
```

### Output Styles

- **`.simple`**
  ```text
  14:10:32 🔵 Fetching user profile
  ```

- **`.detailed`**
  ```text
  ============================================================
  🔵 [DEBUG]
  ============================================================
  Time      : 2026-07-08 10:15:30.123
  File      : LoginViewController.swift
  Function  : loginTapped()
  Line      : 42
  Message   : Fetching user profile
  ============================================================
  ```

### Log Levels

| Level | Emoji |
| :--- | :---: |
| `.verbose` | ⚪️ |
| `.debug` | 🔵 |
| `.info` | 🟢 |
| `.warning` | 🟡 |
| `.error` | 🔴 |
| `.fatal` | ⚫️ |

## File Logging & Custom Sections

When `enableFileLog = true`, logs are written to `<AppName>.log` (in the Documents directory, or Caches directory on tvOS).

```swift
// Append structured/custom blocks (e.g., API responses, SQL queries)
Logger.appendCustomLog(title: "API Response", text: jsonString)

// Read or clear stored logs
let logs = await LoggerManager.shared.readLogs()
await LoggerManager.shared.clearLogs()
```

## Exporting & Sharing Logs

Get the log file URL on any platform:

```swift
if let url = await Logger.exportLogs() {
    print("Log file URL:", url)
}
```

Present the system share UI directly with `LoggerExporter`:

```swift
// iOS, Mac Catalyst, visionOS
Task {
    await LoggerExporter.shareLogs(from: viewController)
}

// macOS (AppKit NSView or NSViewController)
Task {
    await LoggerExporter.shareLogs(from: view)
}
```

> **Note:** tvOS and watchOS do not provide a system share sheet, so `LoggerExporter.shareLogs(from:)` is unavailable on those platforms. Use `Logger.exportLogs()` instead.

## License

MIT License. See [LICENSE](LICENSE) for details.
