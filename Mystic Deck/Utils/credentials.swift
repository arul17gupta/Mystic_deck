//
//  credentials.swift
//  Mystic Deck
//
//  Created by user1 on 26/02/24.
//

import Foundation

class AppData {
    // Singleton instance
    static var shared = AppData()
    var mychance: Int = 0
    // Properties to hold your values
    var username: String = "Arul Gupta"
    var roomID: String = ""
    var isLoggedIn: Bool = false
    var parameter_name: String = ""
    var parameter_value: String = ""
    var score: Int = 0
    var themeselected: String = ""
    var topicselected: String = ""
    
    // Private init to prevent initialization from outside
    private init() {}
}
