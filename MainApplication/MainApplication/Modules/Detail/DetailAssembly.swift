//
//  DetailAssembly.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation
import Swinject

class DetailModule: IModule {
    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView(parameters: [String:Any]) {
        let wireframe = appRouter.resolver.resolve(HomeWireframe.self, argument: appRouter)!
        wireframe.presentView()
    }
}

class DetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(IDetailViewModel.self) { (r, id: String) in
            return DetailViewModel(with: id)
        }
        container.register(DetailController.self) { r in
            guard let viewModel = r.resolve(IDetailViewModel.self) else { fatalError("ViewModel not registered") }
            return DetailController(viewModel: viewModel)
        }
        container.register(DetailWireframe.self) { (r, router: IAppRouter) in
            return DetailWireframe(appRouter: router)
        }
    }
}

class DetailWireframe {
    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView() {
        let view = appRouter.resolver.resolve(DetailController.self)!
        appRouter.displayViewWithoutDismiss(view: view, animateDisplay: false)
    }
}

