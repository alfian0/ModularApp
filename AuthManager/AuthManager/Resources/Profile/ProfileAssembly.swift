//
//  ProfileAssembly.swift
//  AuthManager
//
//  Created by alpiopio on 08/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation
import Swinject
import Core

public class ProfileModule: IModule {
    let appRouter: IAppRouter

    public init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    public func presentView(parameters: [String:Any]) {
        let wireframe = appRouter.resolver.resolve(ProfileWireframe.self, argument: appRouter)!
        wireframe.presentView()
    }
}

public class ProfileAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(ProfileController.self) { r in
            return ProfileController()
        }
        container.register(ProfileWireframe.self) { (r, router: IAppRouter) in
            return ProfileWireframe(appRouter: router)
        }
    }
}

class ProfileWireframe {
    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView() {
        let view = appRouter.resolver.resolve(ProfileController.self)!
        appRouter.resetStackToView(view: view, animated: true)
    }
}
