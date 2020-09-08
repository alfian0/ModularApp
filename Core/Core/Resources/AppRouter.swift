//
//  IAppRouter.swift
//  Core
//
//  Created by alpiopio on 08/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation
import Swinject

public protocol IAppRouter {
    var resolver: Resolver { get }
    
    func presentModule(module: Module, parameters:[String:Any])
    func resetStackToView(view: UIViewController, animated: Bool)
    func displayViewWithoutDismiss(view: UIViewController?, animateDisplay: Bool)
}
