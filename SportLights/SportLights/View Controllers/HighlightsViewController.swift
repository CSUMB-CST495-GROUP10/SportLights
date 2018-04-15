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

class HighlightsViewController: UIViewController {

    @IBOutlet weak var highlightWebView: WKWebView!
    var teamSelected : Team!
    var videoCodes : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = teamSelected.name
        getHighlightVideo()
        //print("Team Name: " + teamName)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getHighlightVideo(){
        
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/search",
                          parameters: ["part":"snippet", "q":formattedSearchParm(), "order":"relevance", "key":"AIzaSyCoZEg3PUGdUDL0vwn54XVeqhoPWKatEfQ"]).responseJSON {
                            (response) in
            if let JSON = response.result.value as? [String:Any]{
                
                for video in JSON["items"] as! NSArray {
                    //var vid = (video as AnyObject).value(forKey: "id")
                    //print(vid!["kind"])
                    //vid.value(forKey: "videoId")
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
        let formattedLocation = self.teamSelected.location.replacingOccurrences(of: " ", with: "+")
        let formattedName = self.teamSelected.name.replacingOccurrences(of: " ", with: "+")
        return "2017+\(formattedLocation)+\(formattedName)+highlights"
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
