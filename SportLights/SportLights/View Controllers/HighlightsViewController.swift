//
//  HighlightsViewController.swift
//  SportLights
//
//  Created by Diego Medina on 4/4/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit
import WebKit

class HighlightsViewController: UIViewController {

    @IBOutlet weak var highlightWebView: WKWebView!
    var teamName : String!
    var teamLocation : String!
    var videoCodes : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = teamName
        getHighlightVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHighlightVideo(){
        self.videoCodes = []
        let filepath = Bundle.main.path(forResource: "keys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filepath!)
        let key = plist?.object(forKey: "google_api") as! String
        let formattedLocation = self.teamLocation.replacingOccurrences(of: " ", with: "+")
        let formattedName = self.teamName.replacingOccurrences(of: " ", with: "+")
        let url_string = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&order=relevance&q=2017+\(formattedLocation + "+" + formattedName)+highlights&key=\(key)"
        //print(url_string)
        let request = URLRequest(url: URL(string: url_string)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){ (data, response, error) in
            
            //print("Response: \(response)")
            
            if let error = error{
                print(error.localizedDescription)
            }
            
            else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
               
                let videos = dataDictionary["items"] as! [[String : Any]]
                var first = true
                for video in videos{
                    
                    if(!first && (video["id"] as! NSDictionary).object(forKey: "kind") as! String == "youtube#video"){
                        self.videoCodes.append((video["id"] as! NSDictionary).object(forKey: "videoId") as! String)
                    }
                    first = false
                }
                if(!self.videoCodes.isEmpty){
                    let url = URL(string:"https://www.youtube.com/watch?v=\(self.videoCodes[0])")
                    self.highlightWebView.load(URLRequest(url: url!))
                }
            }
        
        }
        task.resume()
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
