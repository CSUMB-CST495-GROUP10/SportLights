//
//  SportsLightsUser.swift
//  SportLights
//
//  Created by Samuel on 4/14/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import Foundation
import Parse

class SportLightsUser {
    var username : String?
    var teamsFollowing : [Team]
    var profileImageURL : URL!
    
    private static var _current : SportLightsUser!
//    static var current: SportLightsUser? {
//        get {
//            if _current == nil {
//                let defaults = UserDefaults.standard
//                if let userData = defaults.data(forKey: "currentUserData") {
//                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
//                    _current = User(dictionary: dictionary)
//                }
//            }
//            return _current
//        }
//
//        set (user) {
//            _current = user
//            let defaults = UserDefaults.standard
//            if let user = user {
//                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
//                defaults.set(data, forKey: "currentUserData")
//            } else {
//                defaults.removeObject(forKey: "currentUserData")
//            }
//        }
//    }
    init(username : String) {
        self.username = username
        teamsFollowing = []
        profileImageURL = #imageLiteral(resourceName: "placeHolder_Suit_Male").ciImage?.url
    }
}
