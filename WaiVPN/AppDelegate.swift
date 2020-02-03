//
//  AppDelegate.swift
//  WaiVPN
//
//  Created by Jaden on 25/07/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var fromViewController = ViewController()
    
    // When the app boots up, the code in this function will run.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        let hasLaunched = UserDefaults.standard.bool(forKey: "hasLaunched")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let launchStoryboard = UIStoryboard(name: "Access", bundle: nil)
        let mainStoryboard   = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UIViewController
        
        if hasLaunched {
            vc = mainStoryboard.instantiateInitialViewController()!
        }
        else {
            vc = launchStoryboard.instantiateViewController(withIdentifier: "startController")
            
        }
        
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
         
        
        
        // AdMob will load.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

