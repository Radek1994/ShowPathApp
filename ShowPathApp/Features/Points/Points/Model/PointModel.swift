//
//  PointModel.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 11/10/2023.
//

import Foundation

public struct PointModel {
    public var accuracy: Double = 0.0
    public var altitude: Double = 0.0
    public var distance: Double = 0.0
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
    public var timestamp: Int = 0
}

extension PointModel: Decodable {
    
    enum CodingKeys: String, CodingKey  {
        case accuracy
        case altitude
        case distance
        case latitude
        case longitude
        case timestamp
    }
    
    public init(from decoder: Decoder) throws {
        try self.decode(from: decoder)
    }
    
    private mutating func decode(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let accuracy = try container.decode(String.self, forKey: .accuracy)
        self.accuracy = Double(accuracy) ?? 0.0
        let altitude = try container.decode(String.self, forKey: .altitude)
        self.altitude = Double(altitude) ?? 0.0
        let distance = try container.decode(String.self, forKey: .distance)
        self.distance = Double(distance) ?? 0.0
        let latitude = try container.decode(String.self, forKey: .latitude)
        self.latitude = Double(latitude) ?? 0.0
        let longitude = try container.decode(String.self, forKey: .longitude)
        self.longitude = Double(longitude) ?? 0.0
        let timestamp = try container.decode(String.self, forKey: .timestamp)
        self.timestamp = Int(timestamp) ?? 0
    }
}
