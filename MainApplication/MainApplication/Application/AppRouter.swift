//
//  Assembly.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation
import Swinject
import Core
import AuthManager

class AppRouter: IAppRouter {
    private let assembler: Assembler!
    private let modules : [String:(IAppRouter)->IModule]
    private let navigationController: UINavigationController?
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    static var shared: AppRouter = {
        let assembler = Assembler()
        assembler.apply(assemblies: [
            HomeAssembly(),
            DetailAssembly(),
            ProfileAssembly()
        ])
        
        let modules: [String:(IAppRouter)->IModule] = [
            Module.Home.routePath : {(appRouter: IAppRouter) in HomeModule(appRouter: appRouter)},
            Module.Detail.routePath : {(appRouter: IAppRouter) in DetailModule(appRouter: appRouter)},
            Module.Profile.routePath : {(appRouter: IAppRouter) in ProfileModule(appRouter: appRouter)},
        ]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        guard let navigationController = appDelegate.window?.rootViewController as? UINavigationController else { fatalError() }
        let router = AppRouter(navigationController: navigationController, assembler: assembler, modules: modules)
        return router
    }()
    
    init(navigationController:UINavigationController?, assembler: Assembler, modules: [String:(IAppRouter)->IModule]) {
        self.assembler = assembler
        self.modules = modules
        self.navigationController = navigationController
    }
    
    func presentModule(module: Module, parameters: [String : Any]) {
        if let module = modules[module.routePath] {
            let module = module(self)
            module.presentView(parameters: parameters)
        }
    }
    
    func displayViewWithoutDismiss(view: UIViewController?, animateDisplay: Bool) {
        view?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(view!, animated: true)
    }
    
    func resetStackToView(view: UIViewController, animated: Bool) {
        navigationController?.setViewControllers([view], animated: true)
    }

}
