//
//  TeamListCell.swift
//  SportLights
//
//  Created by Diego Medina on 4/3/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit
import Parse
class TeamListCell: UITableViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!

    var team: Team!
    var league: String!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if PFUser.current() == nil{
            followButton.isHidden = true
        }        
    } 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    
    @IBAction func onFollow(_ sender: Any) {
        let user = PFUser.current()
        if(followButton.currentTitle == "follow") {
            user?.add(team.name,forKey: "TeamName")
            user?.add(team.logoPath, forKey: "TeamLogo")
            user!.add(team.sportsLeague, forKey: "TeamLeague")
            user!.add(team.location, forKey: "TeamLocation")
            user?.saveInBackground()
            followButton.setTitle("unfollow", for: .normal)
        } else{
            user?.remove(team.name, forKey: "TeamName")
            user?.remove(team.logoPath, forKey: "TeamLogo")
            user?.remove(team.sportsLeague, forKey: "TeamLeague")
            user?.remove(team.location, forKey: "TeamLocation")
            user?.saveInBackground()
            followButton.setTitle("follow", for: .normal)
        }
        
    }
    
}
