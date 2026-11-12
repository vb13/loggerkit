//
//  FileLogger.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//


import Foundation

/// A log destination that stores log messages in a file.

///

/// The log file is created automatically inside the application's

/// Documents directory using the application name as the file name.

///

/// Example:

///

/// ```

/// MyApplication.log

/// ```

public actor FileLogger: LogDestination {

    private let fileManager = FileManager.default
    
    /// Returns the log file name.
    /// The file name is generated dynamically using the application's
    /// bundle name.
    /// Example:  MyApplication.log
    private var fileName: String {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? "Application"

        return "\(appName).log"
    }

    public init() {}
    
    /// Writes a formatted log message to the log file.
    ///
    /// - Parameters:
    ///   - message: The log message to write.
    ///   - style: The output format.
    public func write(_ message: LogMessage,style: LogOutputStyle) async {
        let formattedLog = LogFormatter.format(message,style: style)
        append(formattedLog + "\n")
    }

    // MARK: - Private
    /// Appends text to the end of the log file.
    ///
    /// If the file does not exist, it is created automatically.
    ///
    /// - Parameter text: The formatted log text.
    private func append(_ text: String) {
        guard let data = text.data(using: .utf8) else {
            return
        }

        let url = logFileURL()

        if !fileManager.fileExists(atPath: url.path) {
            fileManager.createFile(atPath: url.path,contents: data)
            return
        }

        do {
            let handle = try FileHandle(forWritingTo: url)
            defer {
                try? handle.close()
            }
            try handle.seekToEnd()
            try handle.write(contentsOf: data)
        } catch {

            print("LoggerKit File Error: \(error)")
        }
    }

    private func logFileURL() -> URL {
        #if os(tvOS)
        let directory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
            ?? fileManager.temporaryDirectory
        #else
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? fileManager.temporaryDirectory
        #endif
        return directory.appendingPathComponent(fileName)
    }
    
    /// Appends custom text to the log file.
    ///
    /// Useful for storing API responses, JSON payloads,
    /// SQL queries or any custom debugging information.
    ///
    /// - Parameters:
    ///   - title: Section title.
    ///   - text: Custom text to append.
    public func appendCustomLog(_ title: String, text: String) async {
       let content = """
            ===== \(title) LOG: =====
            \(text)
            ======================
            \n
            """
           append(content)

   }
    /// Reads the contents of the log file.
    ///
    /// - Returns:
    /// A string containing all log entries.
    /// Returns an empty string if the file does not exist.
    public func readLogs() -> String {

        let url = logFileURL()
        print("Log File URL: - \(url)")
        guard fileManager.fileExists(atPath: url.path) else {
            return ""
        }

        return (try? String(contentsOf: url, encoding: .utf8)) ?? ""
    }
    /// Deletes the current log file.
    ///
    /// A new log file will automatically be created
    /// when the next log is written.
    public func clearLogs() {

        let url = logFileURL()

        try? fileManager.removeItem(at: url)
    }
    
    public func exportLogFile() -> URL? {

        guard FileManager.default.fileExists(atPath: logFileURL().path) else {
            return nil
        }

        return logFileURL()
    }
    
}
