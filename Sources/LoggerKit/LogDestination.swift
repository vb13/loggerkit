//
//  LogDestination.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//

/// Represents a destination where log messages can be written.
///
/// Types conforming to this protocol can write logs to
/// different destinations such as:
///
/// - Console
/// - File
///
public protocol LogDestination: Sendable {
    
    /// Writes a log message.
     ///
     /// - Parameters:
     ///   - message: The log message.
     ///   - style: The output format.
    func write(_ message: LogMessage,style: LogOutputStyle) async
}
