//
//  LoggerExporter.swift
//  LoggerKit
//
//  Created by Vatsal B on 07/07/26.
//

import Foundation
#if canImport(UIKit) && !os(tvOS) && !os(watchOS)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Provides functionality to export and share log files.
///
/// `LoggerExporter` presents the system share sheet (`UIActivityViewController`
/// on iOS, Mac Catalyst, and visionOS, or `NSSharingServicePicker` on macOS)
/// to allow users or developers to share the application's log file.
///
/// > Note:
/// > File logging must be enabled using `LoggerConfiguration` before
/// > attempting to export logs.
///
/// ## Example
///
/// ```swift
/// Task {
///     await LoggerExporter.shareLogs(from: self)
/// }
/// ```
public enum LoggerExporter {

    private static func exportURLOrLogWarning() async -> URL? {
        guard let url = await Logger.exportLogs() else {
            let msg = """
                
                LoggerKit: Unable to export logs.                            
                File logging may be disabled or no log file exists.
                            
                Enable file logging using:
                var config = LoggerConfiguration()
                config.enableFileLog = true
                Logger.configure(config)
            """
            Logger.info(msg)
            return nil
        }

        return url
    }

    #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
    /// Presents the system share sheet for the application's log file.
    ///
    /// If file logging is disabled or no log file exists, an informational
    /// message is logged and the share sheet is not presented.
    ///
    /// - Parameter viewController:
    ///   The view controller from which the share sheet should be presented.
    @MainActor
    public static func shareLogs(from viewController: UIViewController) async {
        guard let url = await exportURLOrLogWarning() else {
            return
        }

        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )

        // iPad Support
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = viewController.view
            popover.sourceRect = CGRect(
                x: viewController.view.bounds.midX,
                y: viewController.view.bounds.midY,
                width: 0,
                height: 0
            )
            popover.permittedArrowDirections = []
        }

        viewController.present(activityVC, animated: true)
    }
    #elseif canImport(AppKit)
    /// Presents the system sharing service picker for the application's log file.
    ///
    /// If file logging is disabled or no log file exists, an informational
    /// message is logged and the sharing picker is not presented.
    ///
    /// - Parameter view:
    ///   The view from which the sharing picker should be presented.
    @MainActor
    public static func shareLogs(from view: NSView) async {
        guard let url = await exportURLOrLogWarning() else {
            return
        }

        let picker = NSSharingServicePicker(items: [url])
        picker.show(relativeTo: view.bounds, of: view, preferredEdge: .minY)
    }

    /// Presents the system sharing service picker for the application's log file.
    ///
    /// If file logging is disabled or no log file exists, an informational
    /// message is logged and the sharing picker is not presented.
    ///
    /// - Parameter viewController:
    ///   The view controller from which the sharing picker should be presented.
    @MainActor
    public static func shareLogs(from viewController: NSViewController) async {
        await shareLogs(from: viewController.view)
    }
    #endif
}
