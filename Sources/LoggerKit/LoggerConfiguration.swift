//
//  LoggerConfiguration.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//

import Foundation

/// Defines the configuration settings for LoggerKit.
///
/// Create an instance of `LoggerConfiguration`, customize the
/// required options, and pass it to `Logger.configure(_:)`.
///
/// ## Example
///
/// ```swift
/// var configuration = LoggerConfiguration()
/// configuration.outputStyle = .detailed
/// configuration.enableFileLog = true
/// configuration.minimumLogLevel = .debug
///
/// Logger.configure(configuration)
/// ```
public struct LoggerConfiguration: Sendable {

    // MARK: - Properties

        /// Specifies how log messages are displayed.
        ///
        /// Available styles:
        /// - `simple`
        /// - `detailed`
    public var outputStyle: LogOutputStyle
    /// Enables or disables file logging.
       ///
       /// - `true` : Logs are written to both the console and the log file.
       /// - `false`: Logs are written only to the console.
       ///
       /// Default value is `false`.
    public var enableFileLog: Bool
    /// The minimum severity level that will be logged.
       ///
       /// Messages below this level are ignored.
       ///
       /// Example:
       ///
       /// ```swift
       /// configuration.minimumLogLevel = .warning
       /// ```
       ///
       /// Only `.warning`, `.error`, and `.fatal` logs will be recorded.
    public var minimumLogLevel: LogLevel
    
    /// Creates a new logger configuration.
       ///
       /// - Parameters:
       ///   - outputStyle: The output style for log messages.
       ///   - enableFileLog: Indicates whether file logging is enabled.
       ///   - minimumLogLevel: The minimum log level to record.

    public init(outputStyle: LogOutputStyle = .simple,enableFileLog: Bool = false,minimumLogLevel: LogLevel = .verbose) {
        self.outputStyle = outputStyle
        self.enableFileLog = enableFileLog
        self.minimumLogLevel = minimumLogLevel
    }
}
