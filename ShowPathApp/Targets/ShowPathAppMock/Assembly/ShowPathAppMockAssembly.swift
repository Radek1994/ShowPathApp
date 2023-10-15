//
//  ShowPathAppMockAssembly.swift
//  ShowPathAppMock
//
//  Created by Radoslaw Slesarczyk on 16/10/2023.
//

import Foundation
import Swinject
import Points

class ShowPathAppMockAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(PointsRemoteRepositoryContract.self) { _ in
            return PointsMockRemoteRepository()
        }
    }
}

