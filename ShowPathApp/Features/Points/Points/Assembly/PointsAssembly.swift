//
//  PointsAssembly.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import Swinject

public class PointsAssembly: Assembly {
    
    public init() { }
    
    public func assemble(container: Container) {
        
        container.register(PointsRemoteRepositoryContract.self) { _ in
            return PointsRemoteRepository()
        }
    }
}

