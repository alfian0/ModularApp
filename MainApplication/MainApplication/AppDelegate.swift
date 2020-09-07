//
//  AppDelegate.swift
//  MainApplication
//
//  Created by alpiopio on 01/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import UIKit
import AuthManager
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let viewController: UIViewController = UINavigationController()
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        if AuthManager.shared.canAuthorize {
            AppRouter.shared.presentModule(module: .Home, parameters: [:])
        } else {
            AppRouter.shared.presentModule(module: .Home, parameters: [:])
        }
        
        FirebaseApp.configure()
        
        return true
    }

}

