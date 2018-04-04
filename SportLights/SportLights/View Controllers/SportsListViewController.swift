//
//  SportsListViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/2/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit

class SportsListViewController: UIViewController {

    @IBOutlet weak var chooseSportLabel: UILabel!
    @IBOutlet weak var nflImageView: UIImageView!
    @IBOutlet weak var nhlImageView: UIImageView!
    @IBOutlet weak var nbaImageView: UIImageView!
    @IBOutlet weak var mlbImageView: UIImageView!
    var sportChosen:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nflTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nflTapped(gesture:)))
        let nhlTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nhlTapped(gesture:)))
        let nbaTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nbaTapped(gesture:)))
        let mlbTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.mlbTapped(gesture:)))
        
        nflImageView.addGestureRecognizer(nflTapGesture)
        nflImageView.isUserInteractionEnabled = true
        
        nhlImageView.addGestureRecognizer(nhlTapGesture)
        nhlImageView.isUserInteractionEnabled = true
        
        nbaImageView.addGestureRecognizer(nbaTapGesture)
        nbaImageView.isUserInteractionEnabled = true
        
        mlbImageView.addGestureRecognizer(mlbTapGesture)
        mlbImageView.isUserInteractionEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMainMenuPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func nflTapped(gesture: UIGestureRecognizer) {
        print("NFL")
        sportChosen = "NFL"
        performSegue(withIdentifier: "TeamListSegue", sender: Any?.self)
    }
    
    @objc func nhlTapped(gesture: UIGestureRecognizer) {
        print("NHL")
        sportChosen = "NHL"
        performSegue(withIdentifier: "TeamListSegue", sender: Any?.self)
    }
    
    @objc func nbaTapped(gesture: UIGestureRecognizer) {
        print("NBA")
        sportChosen = "NBA"
        performSegue(withIdentifier: "TeamListSegue", sender: Any?.self)
    }
    
    @objc func mlbTapped(gesture: UIGestureRecognizer) {
        print("MLB")
        sportChosen = "MLB"
        performSegue(withIdentifier: "TeamListSegue", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let data = Data()
        if let destinationViewController = segue.destination as? TeamListViewController {
            destinationViewController.sportChosen = sportChosen
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
