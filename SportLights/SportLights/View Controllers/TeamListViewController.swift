//
//  TeamListViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/3/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit
import Parse

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var logoutButton: UIButton!
    var teamsToDisplay : [Team] = []
    var imagesToDisplay = [UIImage(named: "raiders.gif")] // default value to be overwritten
    var sportChosen:String!
    @IBOutlet weak var teamListTableView: UITableView!
    
    var teams : [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = readDataFromFile(file: "sports_teams")
        let csvRows = csv(data: data!)
        //print(csvRows[1]) //UXM n. 166/167.
        
        fillTeams(rows: csvRows)
        
        // only shows logout if user is logged in
        if PFUser.current() == nil{
            logoutButton.isHidden = true
        }else{
            logoutButton.isHidden = false
        }
        
        // assign correct teams to display
        setTeamsToDisplay(sportsLeague: sportChosen)
        
        self.title = sportChosen
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        
        teamListTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamListCell", for: indexPath) as! TeamListCell
        cell.selectionStyle = .none
        cell.teamNameLabel?.text = teamsToDisplay[indexPath.row].location + " " + teamsToDisplay[indexPath.row].name
        cell.teamImageView.image = UIImage(named: teamsToDisplay[indexPath.row].logoPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsToDisplay.count
    }
    
    @IBAction func onLogoutButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        
        if let indexPath = teamListTableView.indexPath(for: cell){
            let teamName = teamsToDisplay[indexPath.row].name
            let location = teamsToDisplay[indexPath.row].location
            let detailViewController = segue.destination as! HighlightsViewController
            detailViewController.teamName = teamName
            detailViewController.teamLocation = location
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
