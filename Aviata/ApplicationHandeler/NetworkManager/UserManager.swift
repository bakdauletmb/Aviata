//
//  Keys.swift
//  Talim-trend
//
//  Created by Bakdaulet Myrzakerov on 7/23/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//
import Foundation
class UserManager {

    //    MARK: - Properties
    static let userDefaults = UserDefaults.standard

    //    MARK: - Creation of user session

    static func setCurrentToken(to token: String) {
        userDefaults.set(token, forKey: Keys.currentToken)
    }

    static func getCurrentToken() -> String? {
        return userDefaults.string(forKey: Keys.currentToken)
    }
    static func isAuthorized() -> Bool{
        return UserManager.getCurrentToken() != nil
    }

    
}
