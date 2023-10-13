//
//  ConfigReader.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 10/09/2023.
//

import Foundation

public struct ConfigReader {
    private var properties: [String: Any] = [:]
    public static let shared = ConfigReader()
    
    private init() {
        self.properties = self.readProperties()
    }
    
    private func readProperties() -> [String: Any] {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            Logger.debug("Cannot find path for Config.plist")
            return [:]
        }

        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else {
            Logger.debug("Cannot read data for Config.plist")
            return [:]
        }

        guard let properties = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: Any] else {
            Logger.debug("Cannot decode property list for Config.plist")
            return [:]
        }
        
        return properties
    }
    
    public func getProperty<T>(forKey key: String) -> T? {
        return properties[key] as? T
    }
}
