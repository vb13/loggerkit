//
//  LogMessage.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//


import Foundation

public struct LogMessage: Sendable {

    public let level: LogLevel
    public let message: String
    public let file: String
    public let function: String
    public let line: Int
    public let timestamp: Date

    public init(
        level: LogLevel,
        message: String,
        file: String,
        function: String,
        line: Int,
        timestamp: Date = Date()
    ) {
        self.level = level
        self.message = message
        self.file = file
        self.function = function
        self.line = line
        self.timestamp = timestamp
    }
}
