//
//  ProfileViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/9/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import Parse
import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var teamsFollowingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var teamsToDisplay : [Team] = [] // Teams for specified league
    var teamNames: [String] = []
    var teamLogos: [String] = []
    var teamLeagues: [String] = []
    var teamLocations: [String] = []
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let user = PFUser.current()
        self.title = "Profile"
        
        // username
        userNameLabel.text = PFUser.current()?.username
        
//        // member since date
//        let date = PFUser.current()?.createdAt
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM dd,yyyy"
//        let stringDate = dateFormatter.string(from: date as! Date)
//        dateCreatedLabel.text = stringDate
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
