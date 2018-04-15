//
//  SportsLightsUser.swift
//  SportLights
//
//  Created by Samuel on 4/14/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import Foundation
import Parse

class SportLightsUser : PFUser, PFObject{
    var username : String
    var teamsFollowing : [Team]
    var profileImageURL : URL!
    
    private static var _current : SportLightsUser!
    
    init(username : String) {
        self.username = username
        teamsFollowing = []
        profileImageURL = #imageLiteral(resourceName: "placeHolder_Suit_Male").ciImage?.url
    }
}
