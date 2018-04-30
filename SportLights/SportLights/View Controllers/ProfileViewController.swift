//
//  ProfileViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/9/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import Parse
import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var teamsFollowingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var userProfileImageData: UIImage!
    var teamsToDisplay : [Team] = [] // Teams for specified league
    var teamNames: [String] = []
    var teamLogos: [String] = []
    var teamLeagues: [String] = []
    var teamLocations: [String] = []
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let user = PFUser.current()
        
        // profileImage
        let query = PFQuery()
        query.whereKey("username", equalTo: user?.username)
        query.findObjectsInBackground { (object, error) -> Void in
            if error == nil && object != nil{
                print(object!)
                print("here")
                
                for userObject in object!{
                    print("here2")
                    
                    let imagefile = userObject["profileImageFile"] as! PFFile
                    let username = userObject["username"] as! String
                    
                    print(username)
                    print(imagefile)
                }
            }
            else{
                print("ERROR: UNABLE TO FIND USER")
                print(error.debugDescription)
            }
        }
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        
        // username
        userNameLabel.text = PFUser.current()?.username
        
        // member since date
        let date = PFUser.current()?.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        let stringDate = dateFormatter.string(from: date as Date!)
        dateCreatedLabel.text = stringDate
        
        // team information
        if let teamName = user!["TeamName"] as? [String]{
            self.teamNames = teamName
        }
        if let teamLogo = user!["TeamLogo"] as? [String]{
            self.teamLogos = teamLogo
        }
        if let teamLeague = user!["TeamLeague"] as? [String]{
            self.teamLeagues = teamLeague
        }
        if let teamLocation = user!["TeamLocation"] as? [String] {
            self.teamLocations = teamLocation
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingTeams", for: indexPath) as! TeamListCell
        cell.selectionStyle = .none
        cell.teamNameLabel?.text = (self.teamLocations[indexPath.row] as String?)! + " " + self.teamNames[indexPath.row] as String?
        cell.teamImageView.image = UIImage(named: teamLogos[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let detailViewController = segue.destination as! HighlightsViewController
            detailViewController.teamName = self.teamNames[indexPath.row]
            detailViewController.teamLeague = self.teamLeagues[indexPath.row]
            detailViewController.teamLocation = self.teamLocations[indexPath.row]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    @IBAction func onProfileImageButtonPressed(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            print("ENTERED IMAGE PICKER")
            
            // if user has a row in the database: change it's value for the image date
            let query = PFQuery()
            query.whereKey("username", equalTo: PFUser.current()?.username)
            query.findObjectsInBackground { (object, error) in
                if object != nil && error == nil{
                    
                    print("BEFORE FOR LOOP")
                    
                    for user in object!{
                        
                        print("IN FOR LOOP")
                        
                        let imageData = UIImagePNGRepresentation(image)
                        let parseImageFile = PFFile(name: "profileImage.png", data: imageData!)
                        user["profileImageFile"] = parseImageFile
                        self.profileImage.image = image
                        
                        print("USER FOUND IN DATABASE AND ASSIGNED NEW PROFILE IMAGE FILE")
                    }//for
                    
                    print("AFTER FOR LOOP")
                    
                }//if
                else{
                    print(error?.localizedDescription)
                    print(error.debugDescription)
                }
            }
            
        } // if image
        
        // Dismiss UIImagePickerController to go back to your original view controller
        picker.dismiss(animated: true, completion: nil)
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
                let profileImageClass = PFObject(className: "profileImage")
                profileImageClass["userName"] = PFUser.current()?.username
                profileImageClass.saveInBackground { (success, error) in
                    // if able to save to parse
                    if error == nil{
                        let imageData = UIImagePNGRepresentation(image)
                        let parseImageFile = PFFile(name: "profileImage.png", data: imageData!)
                        profileImageClass["profileImageFile"] = parseImageFile
                        profileImageClass.saveInBackground(block: { (success, error) in
                            // if able to upload image
                            if error == nil{
                                print("IMAGE UPLOADED TO PARSE!")
                                self.profileImage.image = image
                            }
                            else{
                                print("ERROR: UNABLE TO SAVE IMAGE TO PARSE!")
                                print(error.debugDescription)
                            }
                        })
                    }
                    else{
                        print("ERROR: UNABLE TO SAVE TO PARSE!")
                        print(error.debugDescription)
                    }
                }
            }//if
            
        } // if image
        
        // Dismiss UIImagePickerController to go back to your original view controller
        picker.dismiss(animated: true, completion: nil)
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
