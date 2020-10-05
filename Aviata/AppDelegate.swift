//
//  AppDelegate.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/3/20.
//

import UIKit
import RealmSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        AppCenter.shared.createWindow(window!)
        AppCenter.shared.start()
        
        return true
    }

}

