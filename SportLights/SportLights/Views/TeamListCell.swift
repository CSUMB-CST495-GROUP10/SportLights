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
    @IBOutlet weak var followButton: UIButton!
    
    var isFollowing: Bool!
    override func awakeFromNib() {
        isFollowing = false
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
        user?.add(team.name,forKey: "TeamName")
        user?.add(team.logoPath, forKey: "TeamLogo")
        user?.saveInBackground()
        followButton.isHidden = true
    }
    
}
