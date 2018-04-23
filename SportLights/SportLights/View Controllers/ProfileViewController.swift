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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var teamsFollowingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var teamsToDisplay : [Team] = [] // Teams for specified league
    var teamNames: [String]!
    var teamLogos: [String]!
    var team: Team!
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = PFUser.current()?.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        let stringDate = dateFormatter.string(from: date as! Date)
        dateCreatedLabel.text = stringDate
        userNameLabel.text = PFUser.current()?.username
        
        let user = PFUser.current()
        
        //print(type(user!["Team"]))
        if let teamName = user!["TeamName"] as? [String]{
            self.teamNames = teamName
            for name in teamName{
               // print(name)
            }
        }
        if let teamLogo = user!["TeamLogo"] as? [String]{
            self.teamLogos = teamLogo
            for logo in teamLogo{
                //print(logo)
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingTeams", for: indexPath) as! TeamListCell
        cell.selectionStyle = .none
        cell.teamNameLabel?.text = self.teamNames[indexPath.row] as String?
        cell.teamImageView.image = UIImage(named: teamLogos[indexPath.row])
        //cell.team = filteredTeams[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let detailViewController = segue.destination as! HighlightsViewController
            
//            if(teamNames[indexPath.row] as String! != nil) {
//                self.team.name = teamNames[indexPath.row]
//            }
//            if(teamLogos[indexPath.row] as String! != nil) {
//                self.team.logoPath = teamLogos[indexPath.row]
//            }
            detailViewController.teamName = self.teamNames[indexPath.row]
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
