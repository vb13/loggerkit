//
//  LogFormatter.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//

import Foundation

/// Converts a `LogMessage` into a formatted string.
///
/// The formatter supports multiple output styles,
/// such as simple and detailed.
public enum LogFormatter {
    /// Formats a log message.
    ///
    /// - Parameters:
    ///   - message: The log message.
    ///   - style: The formatting style.
    /// - Returns:
    /// A formatted string ready for output.
    public static func format(_ message: LogMessage,style: LogOutputStyle) -> String {

        switch style {

        case .simple:
            return simpleLog(message)

        case .detailed:
            return detailedLog(message)
        }
    }

    // MARK: - Simple Print Log
    /// Generates a compact log message.
    ///
    /// Example:
    ///
    /// ```
    /// 14:10:32 🔵 User Login
    /// ```
    private static func simpleLog(_ message: LogMessage) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"

        return "\(formatter.string(from: message.timestamp)) \(message.level.emoji) \(message.message)"
    }
    // MARK: - Detail Print Log
    /// Generates a detailed log message.
    ///
    /// Example:
    ///
    /// ```
    /// ============================================================
    /// 🔵 [DEBUG]
    /// Time      : 2026-07-08 10:15:30.123
    /// File      : LoginVC.swift
    /// Function  : loginTapped()
    /// Line      : 42
    /// Message   : Login Successful
    /// ============================================================
    /// ```
    private static func detailedLog(_ message: LogMessage) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

        let time = formatter.string(from: message.timestamp)

        return """
        ============================================================
        \(message.level.emoji) [\(message.level.title)]
        ============================================================
        Time      : \(time)
        File      : \(message.file)
        Function  : \(message.function)
        Line      : \(message.line)
        Message   : \(message.message)
        ============================================================

        """
    }
}
