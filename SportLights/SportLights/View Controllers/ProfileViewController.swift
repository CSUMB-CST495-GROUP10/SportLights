//
//  ProfileViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/9/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import Parse
import UIKit

class ProfileViewController: UIViewController{

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var teamsFollowingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = PFUser.current()?.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        let stringDate = dateFormatter.string(from: date as! Date)
        dateCreatedLabel.text = stringDate
        userNameLabel.text = PFUser.current()?.username
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogoutPressed(_ sender: Any) {
         NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
