//
//  ApplicationDependency.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 11/09/2023.
//

import Foundation
import Swinject

public class ApplicationDependency {
    public static let shared = ApplicationDependency()
    private var assembler = Assembler([])
    
    private var resolver: Resolver {
        (assembler.resolver as? Container)?.synchronize() ?? assembler.resolver
    }
    
    private init() { }
    
    public func addAssembly(_ assembly: Assembly) {
        assembler.apply(assembly: assembly)
    }
    
    public func addAssemblies(_ assemblies: [Assembly]) {
        assembler.apply(assemblies: assemblies)
    }
    
    public func resolve<T>(_ type: T.Type) -> T? {
        return resolver.resolve(type)
    }
    
    public func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T? {
        return resolver.resolve(type, argument: argument)
    }
}
