//
//  LoginViewController.swift
//  InstagramRedo
//
//  Created by Aashima Garg on 3/1/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidAppear(animated: Bool) {
      
        //if a user is already logged in, go to feed screen
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(userNameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if(user != nil){
                print("User logged in successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else{
                print(error?.localizedDescription)
            }
        }
        
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
    
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = userNameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                 print("User Registered successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)

            } else {
                
                print(error?.localizedDescription)
               
                if error?.code == 202 {
                
                    print("Username is taken.")
                    
                }
                
            }
            
        }
    
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
