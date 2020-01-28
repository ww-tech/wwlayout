//
//  AppDelegate.swift
//  WWLayoutTV
//
//  Created by Steven Grosmark on 1/7/20.
//  Copyright © 2020 WW International. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        
        return true
    }

}
