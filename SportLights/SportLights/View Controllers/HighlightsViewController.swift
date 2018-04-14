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
    var teamName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = teamName
        getHighlightVideo(videoCode: "NtFe5PM87BU")
        print("Team Name: " + teamName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHighlightVideo(videoCode:String){
        
        //"https://www.youtube.com/watch?v="
        //let url = URL(string:"https://www.youtube.com/watch?v=\(videoCode)")
        //highlightWebView.load(URLRequest(url: url!))
        Alamofire.request("https://www.googleapis.com/youtube/v3/search",
                          parameters: ["part":"snippet", "q":teamName, "key":"AIzaSyCoZEg3PUGdUDL0vwn54XVeqhoPWKatEfQ"]).responseJSON {
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
                //print("VIDEO ID:", JSON[0].items.id.videoId);
//                if let nestedDictionary = dictionary["anotherKey"] as? [String: Any] {
//                    // access nested dictionary values by key
//                }
                //print("JSON:\(JSON)")
            }
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
