//
//  ViewController.swift
//  InventoryManagement
//
//  Created by Jacob Solomon on 7/7/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        // Sign user out if logged in when reaching this screen
        if (FIRAuth.auth()?.currentUser != nil ){
            try! FIRAuth.auth()?.signOut()
        }
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        // Login Segue needs to be called within loginAction function to ensure that user
        // login was accepted
        if(identifier == "login"){
            return false
        } else {
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginAction(sender: AnyObject) {
        if(self.emailField.text == "" || self.passField == ""){
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.signInWithEmail(self.emailField.text!, password: self.passField.text!, completion: { (user, error) in
                
                if error == nil{
                    self.passField.text = ""
                    self.performSegueWithIdentifier("login", sender: sender)
                    
                } else {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            
            })
        }
        
    }

}

