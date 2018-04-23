//
//  Team.swift
//  SportLights
//
//  Created by Samuel on 4/9/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import Foundation
import Parse

class Team: PFObject, PFSubclassing{
    @NSManaged var name : String!
    @NSManaged var location : String!
    @NSManaged var abbreviation: String!
    @NSManaged var venue : String!
    @NSManaged var sportsLeague : String!
    @NSManaged var logoPath : String!
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Team"
    }
    
    init(array: [String]){
        super.init()
        self.name = array[0]
        self.location = array[1]
        self.abbreviation = array[5]
        self.logoPath = array[6]
        self.venue = array[3]
        self.sportsLeague = array[4]
    }
}
