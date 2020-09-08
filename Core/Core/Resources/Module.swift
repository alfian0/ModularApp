//
//  Module.swift
//  Core
//
//  Created by alpiopio on 08/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

public protocol IModule {
    func presentView(parameters: [String : Any])
}

public enum Module {
    case Home
    case Detail
    case Profile
    
    public var routePath: String {
        switch self {
        case .Home:
            return "Modules/Home"
        case .Detail:
            return "Modules/Detail"
        case .Profile:
            return "Modules/Profile"
        }
    }
}
