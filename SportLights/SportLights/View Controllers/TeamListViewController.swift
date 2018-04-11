//
//  TeamListViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/3/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit
import Parse

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                              UISearchBarDelegate{
  
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    var filteredTeamsToDisplay = [String]()
    
    var teamsToDisplay = [""]
    var imagesToDisplay = [UIImage(named: "raiders.gif")] // default value to be overwritten
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
    
    let nflTeamLogos = [UIImage(named: "cardinals"),
                        UIImage(named: "falcons"),
                        UIImage(named: "ravens"),
                        UIImage(named: "bills"),
                        UIImage(named: "panthers"),
                        UIImage(named: "bears"),
                        UIImage(named: "bengals"),
                        UIImage(named: "browns"),
                        UIImage(named: "cowboys"),
                        UIImage(named: "broncos"),
                        UIImage(named: "lions"),
                        UIImage(named: "packers"),
                        UIImage(named: "texans"),
                        UIImage(named: "colts"),
                        UIImage(named: "jaguars"),
                        UIImage(named: "chiefs"),
                        UIImage(named: "dolphins"),
                        UIImage(named: "vikings"),
                        UIImage(named: "patriots"),
                        UIImage(named: "saints"),
                        UIImage(named: "giants"),
                        UIImage(named: "jets"),
                        UIImage(named: "raiders"),
                        UIImage(named: "eagles"),
                        UIImage(named: "steelers"),
                        UIImage(named: "chargers"),
                        UIImage(named: "niners"),
                        UIImage(named: "seahawks"),
                        UIImage(named: "rams"),
                        UIImage(named: "buccaneers"),
                        UIImage(named: "titans"),
                        UIImage(named: "redskins")]
    
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
    
    let nhlTeamLogos = [UIImage(named: "ducks"),
                        UIImage(named: "coyotes"),
                        UIImage(named: "bruins"),
                        UIImage(named: "sabres"),
                        UIImage(named: "flames"),
                        UIImage(named: "hurricanes"),
                        UIImage(named: "blackhawks"),
                        UIImage(named: "blueJackets"),
                        UIImage(named: "avalanche"),
                        UIImage(named: "redWings"),
                        UIImage(named: "stars"),
                        UIImage(named: "panthers"),
                        UIImage(named: "oilers"),
                        UIImage(named: "canadiens"),
                        UIImage(named: "kings"),
                        UIImage(named: "devils"),
                        UIImage(named: "wild"),
                        UIImage(named: "islanders"),
                        UIImage(named: "predators"),
                        UIImage(named: "rangers"),
                        UIImage(named: "blues"),
                        UIImage(named: "senators"),
                        UIImage(named: "sharks"),
                        UIImage(named: "flyers"),
                        UIImage(named: "canucks"),
                        UIImage(named: "penguins"),
                        UIImage(named: "goldenKnights"),
                        UIImage(named: "lighting"),
                        UIImage(named: "jets"),
                        UIImage(named: "mapleLeafs"),
                        UIImage(named: "capitals")]
    
    let nbaTeams = ["Atlanta Hawks",
                    "Boston Celtics",
                    "Brooklyn Nets",
                    "Charlotte Hornets",
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
                    "New Orleans Pelicans",
                    "Oklahoma City Thunder",
                    "Orlando Magic",
                    "Phoenix Suns",
                    "Portland Trail Blazers",
                    "Sacramento Kings",
                    "San Antonio Spurs",
                    "Washington Wizards",
                    "Utah Jazz"]
    
    let nbaTeamLogos = [UIImage(named: "hawks"),
                        UIImage(named: "celtics"),
                        UIImage(named: "nets"),
                        UIImage(named: "hornets"),
                        UIImage(named: "bulls"),
                        UIImage(named: "cavaliers"),
                        UIImage(named: "mavericks"),
                        UIImage(named: "nuggets"),
                        UIImage(named: "pistons"),
                        UIImage(named: "warriors"),
                        UIImage(named: "rockets"),
                        UIImage(named: "pacers"),
                        UIImage(named: "knicks"),
                        UIImage(named: "76ers"),
                        UIImage(named: "raptors"),
                        UIImage(named: "clippers"),
                        UIImage(named: "lakers"),
                        UIImage(named: "grizzlies"),
                        UIImage(named: "heat"),
                        UIImage(named: "bucks"),
                        UIImage(named: "timberwolves"),
                        UIImage(named: "pelicans"),
                        UIImage(named: "thunder"),
                        UIImage(named: "magic"),
                        UIImage(named: "suns"),
                        UIImage(named: "trailBlazers"),
                        UIImage(named: "kings"),
                        UIImage(named: "spurs"),
                        UIImage(named: "wizards"),
                        UIImage(named: "jazz")]
    
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
    
    let mlbTeamLogos = [UIImage(named: "diamondbacks"),
                        UIImage(named: "braves"),
                        UIImage(named: "orioles"),
                        UIImage(named: "redSox"),
                        UIImage(named: "cubs"),
                        UIImage(named: "whiteSox"),
                        UIImage(named: "cincinnati"),
                        UIImage(named: "indians"),
                        UIImage(named: "rockies"),
                        UIImage(named: "tigers"),
                        UIImage(named: "marlins"),
                        UIImage(named: "astros"),
                        UIImage(named: "royals"),
                        UIImage(named: "angels"),
                        UIImage(named: "dodgers"),
                        UIImage(named: "brewers"),
                        UIImage(named: "twins"),
                        UIImage(named: "mets"),
                        UIImage(named: "yankees"),
                        UIImage(named: "athletics"),
                        UIImage(named: "phillies"),
                        UIImage(named: "pirates"),
                        UIImage(named: "cardinals-1"),
                        UIImage(named: "padres"),
                        UIImage(named: "giants"),
                        UIImage(named: "mariners"),
                        UIImage(named: "rays"),
                        UIImage(named: "rangers"),
                        UIImage(named: "blueJays"),
                        UIImage(named: "nationals")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // only shows logout if user is logged in
        if PFUser.current() == nil{
//            profileButton.isHidden = true
        }else{
//            profileButton.isHidden = false
        }
        
        // assign correct teams to display
        if sportChosen == "NFL"{
            teamsToDisplay = nflTeams
            imagesToDisplay = nflTeamLogos
        }else if sportChosen == "NHL"{
            teamsToDisplay = nhlTeams
            imagesToDisplay = nhlTeamLogos
        }else if sportChosen == "NBA"{
            teamsToDisplay = nbaTeams
            imagesToDisplay = nbaTeamLogos
        }else{
            teamsToDisplay = mlbTeams
            imagesToDisplay = mlbTeamLogos
        }
        
        // searchbar
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        // change title to team chosen
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
        
        if isSearching{
            cell.teamNameLabel?.text = filteredTeamsToDisplay[indexPath.item]
        }else{
            cell.teamNameLabel?.text = teamsToDisplay[indexPath.item]
            cell.teamImageView.image = imagesToDisplay[indexPath.item]
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return filteredTeamsToDisplay.count
        }
        return teamsToDisplay.count
    }
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = teamListTableView.indexPath(for: cell){
            let teamName = teamsToDisplay[indexPath.row]
            let detailViewController = segue.destination as! HighlightsViewController
            detailViewController.teamName = teamName
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            teamListTableView.reloadData()
        }else{
            isSearching = true
            filteredTeamsToDisplay = teamsToDisplay.filter({($0.lowercased().contains(searchBar.text!.lowercased()))})
            teamListTableView.reloadData()
        }
    }
    
    @IBAction func onProfilePressed(_ sender: Any) {
        
        print("hello")
        
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
