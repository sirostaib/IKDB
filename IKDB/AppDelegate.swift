//
//  AppDelegate.swift
//  IKDB
//
//  Created by Siros Taib on 6/23/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame:  UIScreen.main.bounds)
        window.rootViewController = MainVC()
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }

}

