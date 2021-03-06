//
//  HomeAssembly.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation
import Swinject
import Core
import AuthManager

public class HomeModule: IModule {
    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    public func presentView(parameters: [String:Any]) {
        let wireframe = appRouter.resolver.resolve(HomeWireframe.self, argument: appRouter)!
        wireframe.presentView()
    }
}

public class HomeAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(IHomeViewModel.self) { r in
            return HomeViewModel()
        }
        container.register(HomeController.self) { r in
            guard let viewModel = r.resolve(IHomeViewModel.self) else { fatalError("ViewModel not registered") }
            return HomeController(viewModel: viewModel)
        }
        container.register(HomeWireframe.self) { (r, router: IAppRouter) in
            return HomeWireframe(appRouter: router)
        }
    }
}

class HomeWireframe {
    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView() {
        let view = appRouter.resolver.resolve(HomeController.self)!
        appRouter.resetStackToView(view: view, animated: true)
    }
    
    func presentProfile() {
        let view = appRouter.resolver.resolve(ProfileController.self)!
        appRouter.resetStackToView(view: view, animated: true)
    }
}
