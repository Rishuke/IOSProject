//
//  AppDelegate.swift
//  iosFrontApp
//
//  Created by Etudiant on 22/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var token: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                self.bootIPadApp()
            default:
                self.bootIPhoneApp()
        }
        
        return true
    }
    
    func bootIPhoneApp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func bootIPadApp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
       
        
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window.makeKeyAndVisible()
        self.window = window
    }
}

