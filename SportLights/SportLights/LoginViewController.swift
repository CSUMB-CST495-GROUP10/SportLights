//
//  LoginViewController.swift
//  SportLights
//
//  Created by Israel Andrade on 3/26/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userName.text!, password: password.text!) { (user: PFUser?, error: Error?) in
            if(user != nil) {
                print("You're logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Wrong username/password")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = userName.text
        newUser.password = password.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if(success) {
                print("Yay, Created a user!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                if(error?._code == 202) {
                    print("User name is taken")
                }
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
