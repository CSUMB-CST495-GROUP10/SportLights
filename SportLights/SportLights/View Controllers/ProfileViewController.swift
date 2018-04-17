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

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var teamsFollowingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var alertController : UIAlertController!
    var logoutSecondChance : UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = PFUser.current()?.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        let stringDate = dateFormatter.string(from: date as! Date)
        dateCreatedLabel.text = stringDate
        userNameLabel.text = PFUser.current()?.username
        
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        logoutSecondChance = UIAlertController(title: nil, message: "Are you sure?", preferredStyle: .alert)
        
        let logout = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            // Logout
            self.present(self.logoutSecondChance, animated: true, completion: {
            })
        }
        
        let logoutFinal = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        }
        
        let editProfile = UIAlertAction(title: "Edit", style: .default) { (action) in
            // Switch to edit profile vc
            self.performSegue(withIdentifier: "editProfile", sender: self)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // Cancel
        }
        
        let cancelFinal = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
            
        }
        
        alertController.addAction(logout)
        alertController.addAction(editProfile)
        alertController.addAction(cancel)
        
        logoutSecondChance.addAction(logoutFinal)
        logoutSecondChance.addAction(cancelFinal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSettingsTap(_ sender: Any) {
        print("Setting button pressed!")
        present(alertController, animated: true) {
            // Something on completion
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
            if(segue.identifier == "editProfile"){
                let destVC = segue.destination as! EditProfileViewController
            }
        }
 

}
