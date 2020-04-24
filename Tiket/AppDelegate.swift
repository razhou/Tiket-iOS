//
//  AppDelegate.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 21/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
     static let current = UIApplication.shared.delegate as! AppDelegate
     var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController.init(nibName: HomeViewController.stringRepresentation, bundle: nil)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }




}

