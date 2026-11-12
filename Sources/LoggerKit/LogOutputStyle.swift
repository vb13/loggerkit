//
//  LogOutputStyle.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//


import Foundation

/// Defines how log messages are formatted before being written
/// to the configured log destinations.
///
/// `LogOutputStyle` controls the appearance of log output in
/// both the console and log files.
///
/// ## Available Styles
///
/// - `simple`
///   Displays a concise log entry containing the timestamp,
///   log level, and message.
///
///   Example:
///   ```
///   14:25:18 🔵 User logged in
///   ```
///
/// - `detailed`
///   Displays complete debugging information including the
///   timestamp, source file, function name, line number,
///   log level, and message.
///
///   Example:
///   ```
///   ============================================================
///   🔵 [DEBUG]
///   Time      : 2026-07-08 14:25:18.231
///   File      : LoginViewController.swift
///   Function  : loginButtonTapped()
///   Line      : 42
///   Message   : User logged in
///   ============================================================
///   ```

public enum LogOutputStyle: Sendable {
    /// Displays a compact, single-line log message.
    ///
    /// Recommended for production builds where concise logging
    /// is preferred.
    case simple
    
    /// Displays a detailed, multi-line log message.
    ///
    /// Recommended during development and debugging to provide
    /// additional context such as the source file, function,
    /// and line number.
    case detailed
}
