//
//  AppDelegate.swift
//  PitchPerfect
//
//  Created by Jesus Marcano on 8/13/15.
//  Copyright © 2015 Agencia Secreta 86. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var rootVC: ViewController {
        get {
            return window?.rootViewController as! ViewController
        }
    }
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // inform the view controller.
        rootVC.stopRecording()
                
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Inform the view controller.
        rootVC.appInBackground()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

