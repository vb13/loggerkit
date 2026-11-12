//
//  LoggerManager.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//

import Foundation

public actor LoggerManager {
    
    // MARK: - Shared Instance
    // Shared singleton instance used internally by LoggerKit.
    public static let shared = LoggerManager()
    
    // MARK: - Properties
    // Current logger configuration.
    private var loggerConfiguration = LoggerConfiguration()
    
    // Console log destination.
    private let console = ConsoleLogger()
    
    // File log destination.
    private let file = FileLogger()
    
    // MARK: - Configuration
    
    /// Applies a new logger configuration.
    ///
    /// - Parameter configuration: The logger configuration.
    public func configure(_ configuration: LoggerConfiguration) {
        loggerConfiguration = configuration
    }
    /// Returns the current logger configuration.
    ///
    /// - Returns: Current `LoggerConfiguration`.
    public func configuration() -> LoggerConfiguration {
        loggerConfiguration
    }
    
    // MARK: - Logging
    
    /// Processes a log message and forwards it to the
    /// configured log destinations.
    ///
    /// Logs below the configured minimum log level are ignored.
    ///
    /// - Parameter message: The log message to process.
    func log(_ message: LogMessage) async {
        
        guard message.level.rawValue >= loggerConfiguration.minimumLogLevel.rawValue else {
            return
        }
        
        await console.write(message,style: loggerConfiguration.outputStyle)
        
        if loggerConfiguration.enableFileLog {
            await file.write(message,style: loggerConfiguration.outputStyle)
        }
    }
    // MARK: - Custom Logs
    
    /// Appends custom text directly to the log file.
    ///
    /// - Parameters:
    ///   - title: Section title.
    ///   - text: Custom content.
    public func appendCustomLog(_ title: String,text: String) async {
        
        guard loggerConfiguration.enableFileLog else {
            return
        }
        
        await file.appendCustomLog(title,text: text)
    }
    
    // MARK: - File Operations
    
    /// Reads all logs from the log file.
    ///
    /// - Returns:
    /// A string containing all log entries.
    public func readLogs() async -> String {
        
        guard loggerConfiguration.enableFileLog else {
            return "File logging is disabled."
        }
        
        return await file.readLogs()
    }
    
    /// Deletes the current log file.
    public func clearLogs() async {
        
        guard loggerConfiguration.enableFileLog else {
            return
        }
        
        await file.clearLogs()
    }
    /// Returns the log file URL for exporting or sharing.
    ///
    /// - Returns:
    /// The log file URL if available; otherwise `nil`.
    public func exportLogs() async -> URL? {
        
        guard loggerConfiguration.enableFileLog else {
            return nil
        }
        
        return await file.exportLogFile()
    }
    
}
