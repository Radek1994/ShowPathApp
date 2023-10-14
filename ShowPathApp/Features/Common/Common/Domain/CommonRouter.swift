//
//  CommonRouter.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 13/10/2023.
//

import Foundation
import UIKit

public struct CommonRouter {
    public func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
