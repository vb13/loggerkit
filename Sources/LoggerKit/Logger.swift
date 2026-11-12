//
//  Logger.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//


import Foundation

/// The primary entry point for the LoggerKit framework.
///
/// `Logger` provides a simple API for writing log messages,
/// configuring the logging system, and exporting log files.
///
/// ## Example
///
/// ```swift
/// Logger.debug("Application Started")
///
/// Logger.info("User logged in")
///
/// Logger.error("API request failed")
/// ```
///
/// ## Configuration
///
/// ```swift
/// var configuration = LoggerConfiguration()
/// configuration.outputStyle = .detailed
/// configuration.enableFileLogging = true
///
/// Logger.configure(configuration)
/// ```
public enum Logger {
    
    // MARK: - Private Log Method
    /// Creates a log message and forwards it to the logger manager.
    ///
    /// - Parameters:
    ///   - level: Severity level of the log.
    ///   - message: Log message.
    ///   - file: Source file name.
    ///   - function: Function name.
    ///   - line: Line number.
    private static func log(level: LogLevel,message: String,file: String,function: String,line: Int) {
        let logMessage = LogMessage(level: level,message: message,file: file,function: function,line: line)
        Task.detached(priority: .utility) {
            await LoggerManager.shared.log(logMessage)
        }
    }
    
    // MARK: - Verbose
    /// Writes a verbose log.
    ///
    /// Use for highly detailed debugging information.
    ///
    /// ```swift
    /// Logger.verbose("View loaded")
    /// ```
    public static func verbose(_ message: String,file: String = #fileID,function: String = #function,line: Int = #line) {
        
        log(level: .verbose,message: message,file: file,function: function,line: line)
        
    }
    
    // MARK: - Debug
    /// Writes a debug log.
    ///
    /// Use during development to trace application flow.
    ///
    /// ```swift
    /// Logger.debug("Login API called")
    /// ```
    public static func debug(_ message: String,file: String = #fileID,function: String = #function,line: Int = #line) {
        
        log(level: .debug,message: message,file: file,function: function,line: line)
    }
    
    // MARK: - Info
    /// Writes an informational log.
    ///
    /// ```swift
    /// Logger.info("User logged in successfully")
    /// ```
    public static func info(_ message: String,file: String = #fileID,function: String = #function,line: Int = #line) {
        
        log(level: .info,message: message,file: file,function: function,line: line)
    }
    
    // MARK: - Warning
    /// Writes a warning log.
    ///
    /// Use for unexpected situations that do not stop the application.
    ///
    /// ```swift
    /// Logger.warning("Location permission denied")
    /// ```
    public static func warning(_ message: String,file: String = #fileID,function: String = #function,line: Int = #line) {
        
        log(level: .warning,message: message,file: file,function: function,line: line)
    }
    
    // MARK: - Error
    /// Writes an error log.
    ///
    /// Use when an operation fails.
    ///
    /// ```swift
    /// Logger.error("Unable to fetch profile")
    /// ```
    public static func error(_ message: String,file: String = #fileID,function: String = #function,line: Int = #line) {
        
        log(level: .error,message: message,file: file,function: function,line: line)
    }
    
    // MARK: - Fatal
    /// Writes a fatal log.
    ///
    /// Use for unrecoverable errors.
    ///
    /// ```swift
    /// Logger.fatal("Database corruption detected")
    /// ```
    public static func fatal(_ message: String,file: String = #fileID,function: String = #function,line: Int = #line) {
        
        log(level: .fatal,message: message,file: file,function: function,line: line)
    }
    
    // MARK: - Custom File Log
    /// Appends custom text directly to the log file.
    ///
    /// This is useful for logging API responses,
    /// JSON payloads, SQL queries or any custom data.
    ///
    /// > Note:
    /// > File logging must be enabled in `LoggerConfiguration`.
    ///
    /// ```swift
    /// Logger.appendCustomLog(
    ///     title: "API Response",
    ///     text: jsonString
    /// )
    /// ```
    public static func appendCustomLog(title: String, text: String) {
        
        Task.detached(priority: .utility) {
            await LoggerManager.shared.appendCustomLog(title, text: text)
        }
    }
    
    // MARK: - Configuration
    
    /// Configures LoggerKit.
    ///
    /// Call this once during application startup.
    ///
    /// ```swift
    /// var configuration = LoggerConfiguration()
    /// configuration.outputStyle = .detailed
    /// configuration.enableFileLogging = true
    ///
    /// Logger.configure(configuration)
    /// ```
    public static func configure(_ configuration: LoggerConfiguration) {
        Task.detached(priority: .utility) {
            await LoggerManager.shared.configure(configuration)
        }
    }
    
    // MARK: - Export Logs
    
    /// Returns the log file URL for exporting or sharing.
    ///
    /// - Returns:
    /// The URL of the log file if it exists; otherwise `nil`.
    ///
    /// ```swift
    /// if let url = await Logger.exportLogs() {
    ///     print(url)
    /// }
    /// ```
    public static func exportLogs() async -> URL? {
        await LoggerManager.shared.exportLogs()
    }
    
}
