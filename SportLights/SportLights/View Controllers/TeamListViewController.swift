//
//  TeamListViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/3/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var teamsToDisplay = [""]
    var sportChosen:String!
    @IBOutlet weak var teamListTableView: UITableView!
    
    let nflTeams = ["Arizona Cardinals",
        "Atlanta Falcons",
        "Baltimore Ravens",
        "Buffalo Bills",
        "Carolina Panthers",
        "Chicago Bears",
        "Cincinnati Bengals",
        "Cleveland Browns",
        "Dallas Cowboys",
        "Denver Broncos",
        "Detroit Lions",
        "Green Bay Packers",
        "Houston Texans",
        "Indianapolis Colts",
        "Jacksonville Jaguars",
        "Kansas City Chiefs",
        "Miami Dolphins",
        "Minnesota Vikings",
        "New England Patriots",
        "New Orleans Saints",
        "New York Giants",
        "New York Jets",
        "Oakland Raiders",
        "Philadelphia Eagles",
        "Pittsburgh Steelers",
        "San Diego Chargers",
        "San Francisco 49ers",
        "Seattle Seahawks",
        "St. Louis Rams",
        "Tampa Bay Buccaneers",
        "Tennessee Titans",
        "Washington Redskins"]
    
    let nhlTeams = ["Anaheim Ducks",
        "Arizona Coyotes",
        "Boston Bruins",
        "Buffalo Sabres",
        "Calgary Flames",
        "Carolina Hurricanes",
        "Chicago Blackhawks",
        "Columbus Blue Jackets",
        "Colorado Avalanche",
        "Detroit Red Wings",
        "Dallas Stars",
        "Florida Panthers",
        "Edmonton Oilers",
        "Montreal Canadiens",
        "Los Angeles Kings",
        "New Jersey Devils",
        "Minnesota Wild",
        "New York Islanders",
        "Nashville Predators",
        "New York Rangers",
        "Saint Louis Blues",
        "Ottawa Senators",
        "San Jose Sharks",
        "Philadelphia Flyers",
        "Vancouver Canucks",
        "Pittsburgh Penguins",
        "Vegas Golden Knights",
        "Tampa Bay Lightning",
        "Winnipeg Jets Toronto",
        "Maple Leafs",
        "Washington Capitals"]
    
    let nbaTeams = ["Atlanta Hawks",
                    "Boston Celtics",
        "Brooklyn Nets",
        "Charlotte Bobcats",
        "Chicago Bulls",
        "Cleveland Cavaliers",
        "Dallas Mavericks",
        "Denver Nuggets",
        "Detroit Pistons",
        "Golden State Warriors",
        "Houston Rockets",
        "Indiana Pacers",
        "New York Knicks",
        "Philadelphia 76ers",
        "Toronto Raptors",
        "Los Angeles Clippers",
        "Los Angeles Lakers",
        "Memphis Grizzlies",
        "Miami Heat",
        "Milwaukee Bucks",
        "Minnesota Timberwolves",
        "New Orleans Hornets",
        "Oklahoma City Thunder",
        "Orlando Magic",
        "Phoenix Suns",
        "Portland Trail Blazers",
        "Sacramento Kings",
        "San Antonio Spurs",
        "Washington Wizards",
        "Utah Jazz"]
    
    let mlbTeams = ["Arizona Diamondbacks",
        "Atlanta Braves",
        "Baltimore Orioles",
        "Boston Red Sox",
        "Chicago Cubs",
        "Chicago White Sox",
        "Cincinnati Reds",
        "Cleveland Indians",
        "Colorado Rockies",
        "Detroit Tigers",
        "Miami Marlins",
        "Houston Astros",
        "Kansas City Royals",
        "Los Angeles Angels of Anaheim",
        "Los Angeles Dodgers",
        "Milwaukee Brewers",
        "Minnesota Twins",
        "New York Mets",
        "New York Yankees",
        "Oakland Athletics",
        "Philadelphia Phillies",
        "Pittsburgh Pirates",
        "Saint (St.) Louis Cardinals",
        "San Diego Padres",
        "San Francisco Giants",
        "Seattle Mariners",
        "Tampa Bay Rays",
        "Texas Rangers",
        "Toronto Blue Jays",
        "Washington Nationals"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assign correct teams to display
        if sportChosen == "NFL"{
            teamsToDisplay = nflTeams
        }else if sportChosen == "NHL"{
            teamsToDisplay = nhlTeams
        }else if sportChosen == "NBA"{
            teamsToDisplay = nbaTeams
        }else{
            teamsToDisplay = mlbTeams
        }
        
        teamListTableView.reloadData()

        self.title = sportChosen
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        
        teamListTableView.reloadData()
//        teamListTableView.rowHeight = UITableViewAutomaticDimension
//        teamListTableView.estimatedRowHeight = 220
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamListCell", for: indexPath) as! TeamListCell
        cell.teamNameLabel?.text = teamsToDisplay[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsToDisplay.count
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
