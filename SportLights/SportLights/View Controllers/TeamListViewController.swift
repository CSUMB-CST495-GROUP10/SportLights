//
//  TeamListViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/3/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit
import Parse

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
   // @IBOutlet weak var logoutButton: UIButton!
    
    var teams : [Team] = [] // All teams across all sports
    var teamsToDisplay : [Team] = [] // Teams for specified league
    var filteredTeams : [Team] = [] // Teams for search filter
    
    var isSearching = false

    
    var imagesToDisplay = [UIImage(named: "raiders.gif")] // default value to be overwritten
    var sportChosen:String!
    @IBOutlet weak var teamListTableView: UITableView!
    
    var teamNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = readDataFromFile(file: "sports_teams")
        let csvRows = csv(data: data!)
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        // assign correct teams to display
        fillTeams(rows: csvRows)
        setTeamsToDisplay(sportsLeague: sportChosen)
        filteredTeams = teamsToDisplay
        
        self.title = sportChosen
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        let user = PFUser.current()
        if(user != nil) {
            if let teamName = user!["TeamName"] as? [String]{
                self.teamNames = teamName
            }
        }
        teamListTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamListCell", for: indexPath) as! TeamListCell
        cell.selectionStyle = .none
        cell.teamNameLabel?.text = filteredTeams[indexPath.row].location + " " + filteredTeams[indexPath.row].name
        cell.teamImageView.image = UIImage(named: filteredTeams[indexPath.row].logoPath)
        cell.team = filteredTeams[indexPath.row]

        let user = PFUser.current()
        if(user != nil) {
            var target = cell.teamNameLabel.text!.split(separator: " ")[1]
            if teamNames.contains(target.description){
                print("Found")
                print("Team Name: ", target.description)
                //teamNames.remove(at: teamNames.index(of: target.description)!)
                //cell.followButton.isHidden = true
                cell.followButton.setTitle("unfollow", for: .normal)

            }
            else{
                cell.followButton.isHidden = false
                cell.followButton.setTitle("follow", for: .normal)
            }

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching{
            return filteredTeams.count
        }
        return teamsToDisplay.count
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = teamListTableView.indexPath(for: cell){
            let detailViewController = segue.destination as! HighlightsViewController
            detailViewController.teamSelected = filteredTeams[indexPath.row]
        }
    }
    
    func readDataFromFile(file:String) -> String!{
        guard let filepath = Bundle.main.path(forResource: file, ofType: "csv")
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
       
        return cleanFile
    }
    
    func fillTeams(rows : [[String]]){
        for row in rows{
            teams.append(Team(array: row))
        }
    }
    
    func setTeamsToDisplay(sportsLeague : String){
        teamsToDisplay = []
        for team in teams{
            if(team.sportsLeague == sportsLeague){
                teamsToDisplay.append(team)
            }
        }
        teamsToDisplay.sort{
            $0.location < $1.location
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            filteredTeams = teamsToDisplay
            view.endEditing(true)
            teamListTableView.reloadData()
        }else{
            isSearching = true
            filteredTeams = teamsToDisplay.filter({ (team) -> Bool in
                let formattedPossibleMatch = team.location.lowercased() + " " + team.name.lowercased()
                return formattedPossibleMatch.contains(searchText.lowercased())
            })
            teamListTableView.reloadData()
        }
    }
    
    @IBAction func onProfilePressed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        self.present(nextViewController, animated:true, completion:nil)
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
