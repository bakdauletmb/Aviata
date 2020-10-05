//
//  AppConstants.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
final class AppConstants {
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let navBarHeight = UINavigationController().navigationBar.bounds.height
    static let smallNavBarHeight = 40
    static let totalNaBarHeight = statusBarHeight + navBarHeight
    
    
    static func getTabbarHeight(_ tabBarController: UITabBarController?) -> CGFloat {
        guard let tabBarController = tabBarController else { return 0.0 }
        return tabBarController.tabBar.frame.size.height
    }

    class API {
        static let baseUrl = "https://newsapi.org"
        static let topHeadlines = "/v2/top-headlines"
        static let everything = "/v2/everything"
        static let APIKey = "e65ee0938a2a43ebb15923b48faed18d"
    }

    
}
