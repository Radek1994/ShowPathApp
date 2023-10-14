//
//  CommonPath.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 13/10/2023.
//

import Foundation
import UIKit

public typealias PathTarget<Arg> = (Arg) -> (UIViewController)

public protocol Path {
    associatedtype Arg
    
    var pathTarget: PathTarget<Arg> { get }
    
    func follow(from viewController: UIViewController, arg: Arg)
}

public class ShowPath<Arg>: Path {
    public var pathTarget: PathTarget<Arg>
    
    public init(pathTarget: @escaping PathTarget<Arg>) {
        self.pathTarget = pathTarget
    }
    
    public func follow(from viewController: UIViewController, arg: Arg = ()) {
        let targetViewController = pathTarget(arg)
        viewController.show(targetViewController, sender: nil)
    }
}

public class ModalPath<Arg>: Path {
    public var pathTarget: PathTarget<Arg>
    
    public init(pathTarget: @escaping PathTarget<Arg>) {
        self.pathTarget = pathTarget
    }
    
    public func follow(from viewController: UIViewController, arg: Arg = ()) {
        let targetViewController = pathTarget(arg)
        viewController.present(targetViewController, animated: true)
    }
}
