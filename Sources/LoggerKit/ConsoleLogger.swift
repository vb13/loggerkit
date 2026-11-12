//
//  ConsoleLogger.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//


import Foundation

/// A log destination that writes log messages to the Xcode console.
///
/// `ConsoleLogger` is enabled by default and prints log messages
/// using the configured `LogOutputStyle` (simple or detailed).
public actor ConsoleLogger: LogDestination {

    /// Writes a formatted log message to the console.
    ///
    /// - Parameters:
    ///   - message: The log message to print.
    ///   - style: The output format used to display the log.
    public func write(
        _ message: LogMessage,
        style: LogOutputStyle
    ) async {

        print(LogFormatter.format(message, style: style))
    }
}
