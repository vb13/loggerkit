//
//  LogLevel.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//


import Foundation

public enum LogLevel: Int, CaseIterable,Sendable {

    case verbose
    case debug
    case info
    case warning
    case error
    case fatal

    public var emoji: String {
        switch self {
        case .verbose:
            return "⚪️"

        case .debug:
            return "🔵"

        case .info:
            return "🟢"

        case .warning:
            return "🟡"

        case .error:
            return "🔴"

        case .fatal:
            return "⚫️"
        }
    }

    public var title: String {
        switch self {

        case .verbose:
            return "VERBOSE"

        case .debug:
            return "DEBUG"

        case .info:
            return "INFO"

        case .warning:
            return "WARNING"

        case .error:
            return "ERROR"

        case .fatal:
            return "FATAL"
        }
    }
}
