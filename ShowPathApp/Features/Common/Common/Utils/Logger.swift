//
//  Logger.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 08/09/2023.
//

import Foundation
import XCGLogger

public class Logger {
    private static let shared = Logger()
    private var logger: XCGLogger?
    
    private init() {
        setup()
    }
    
    private func setup() {
        let log = XCGLogger(identifier: "XCGLogger", includeDefaultDestinations: false)
        
        let systemDestination = ConsoleDestination(identifier: "XCGLogger.systemDestination")
        
        systemDestination.outputLevel = .debug
        systemDestination.showLogIdentifier = false
        systemDestination.showFunctionName = true
        systemDestination.showThreadName = true
        systemDestination.showLevel = true
        systemDestination.showFileName = true
        systemDestination.showLineNumber = true
        systemDestination.showDate = true
        
        log.add(destination: systemDestination)
        
        log.logAppDetails()
        
        self.logger = log
    }
    
    public static func error(_ error: Error, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        Logger.shared.logger?.error(error.localizedDescription, functionName: function, fileName: file, lineNumber: line)
    }
    
    public static func debug(_ text: String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        Logger.shared.logger?.debug(text, functionName: function, fileName: file, lineNumber: line)
    }
}
