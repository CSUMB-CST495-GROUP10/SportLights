//
//  Team.swift
//  SportLights
//
//  Created by Samuel on 4/9/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import Foundation

class Team{
    var name : String!
    var location : String!
    var abbreviation: String!
    var venue : String!
    var sportsLeague : String!
    var logoPath : String!
    
    init(array: [String]){
        name = array[0]
        location = array[1]
        abbreviation = array[5]
        logoPath = array[6]
        venue = array[3]
        sportsLeague = array[4]
    }
    
    
    
}
