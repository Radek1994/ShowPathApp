//
//  ApplicationDependencySetup.swift
//  ShowPathAppMock
//
//  Created by Radoslaw Slesarczyk on 16/10/2023.
//

import Foundation
import Common
import Points

class ApplicationDependencySetup {
    
    func setup() {
        ApplicationDependency.shared.addAssemblies([PointsAssembly(),
                                                    ShowPathAppMockAssembly()])
    }
}

