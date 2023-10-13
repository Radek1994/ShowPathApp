//
//  ViewModel.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 08/09/2023.
//

import Foundation
import Combine
import SwiftUI

open class ViewModel: ObservableObject {
    
    @Published public var isLoading: Bool = false
    @Published public var error: CommonError? = nil
    public var cancellables: Set<AnyCancellable> = []
    
    public var isShowingError: Binding<Bool> {
        Binding {
            self.error != nil
        } set: { _ in
            self.error = nil
        }
    }
    
    public init() { }
}
