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

class HighlightsViewController: UIViewController {

    @IBOutlet weak var highlightWebView: WKWebView!
    var teamName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = teamName
        getHighlightVideo(videoCode: "NtFe5PM87BU")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHighlightVideo(videoCode:String){
        let url = URL(string:"https://www.youtube.com/watch?v=\(videoCode)")
        highlightWebView.load(URLRequest(url: url!))
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
