//
//  HighlightsViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/4/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit
import WebKit
import Parse
import Alamofire
import Foundation
class HighlightsViewController: UIViewController {

    @IBOutlet weak var highlightWebView: WKWebView!
    var teamSelected : Team!
    var videoCodes : [String] = []
    var teamName: String!
    var teamLeague:String!
    var teamLocation: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        getHighlightVideo()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getHighlightVideo(){
        
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/search",
                          parameters: ["part":"snippet", "q":formattedSearchParm(), "order":"relevance","channelId": getChannelId(),
                                       "key":"AIzaSyCoZEg3PUGdUDL0vwn54XVeqhoPWKatEfQ"]).responseJSON {
                            (response) in
            if let JSON = response.result.value as? [String:Any]{
                for video in JSON["items"] as! NSArray {
                    var vid = (video as AnyObject).value(forKey: "id")
                    vid = (vid as AnyObject).value(forKey: "videoId")
                    let highlight = vid as! String
                    print(highlight)
                     let url = URL(string:"https://www.youtube.com/watch?v=\(highlight)")
                    self.highlightWebView.load(URLRequest(url: url!))
                    return
                }
            }
        }
    }
    
    func formattedSearchParm() -> String{
        if(teamSelected != nil) {
            let formattedLocation = self.teamSelected.location.replacingOccurrences(of: " ", with: "+")
            let formattedName = self.teamSelected.name.replacingOccurrences(of: " ", with: "+")
            print("\(formattedLocation)+\(formattedName)")
            return "\(formattedLocation)+\(formattedName)"
        }
       
        if(teamName != nil && teamLocation != nil) {
            let formattedLocation = self.teamLocation.replacingOccurrences(of: " ", with: "+")
            let formattedName = self.teamName.replacingOccurrences(of: " ", with: "+")
            print("\(formattedLocation)+\(formattedName)")
            return "\(formattedLocation)+\(formattedName)"
        }
        return ""

    }
    func getChannelId() -> String{
        if(teamSelected != nil) {
            if(teamSelected.sportsLeague == "MLB"){
                return "UCoLrcjPV5PbUrUyXq5mjc_A"
            }
            else if(teamSelected.sportsLeague == "NHL"){
                return "UCqFMzb-4AUf6WAIbl132QKA"
            }
            else if(teamSelected.sportsLeague == "NFL") {
                return "UCDVYQ4Zhbm3S2dlz7P1GBDg"
            }
            else if(teamSelected.sportsLeague == "NBA") {
                return "UCWJ2lWNubArHWmf3FIHbfcQ"
            }
        }
        if(teamLeague != nil){
            if(teamLeague == "MLB"){
                return "UCoLrcjPV5PbUrUyXq5mjc_A"
            }
            else if(teamLeague == "NHL"){
                return "UCqFMzb-4AUf6WAIbl132QKA"
            }
            else if(teamLeague == "NFL") {
                return "UCDVYQ4Zhbm3S2dlz7P1GBDg"
            }
            else if(teamLeague == "NBA") {
                return "UCWJ2lWNubArHWmf3FIHbfcQ"
            }
        }
            return ""
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
