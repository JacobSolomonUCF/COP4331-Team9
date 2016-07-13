//
//  CreateAccountViewController.swift
//  InventoryManagement
//
//  Created by Robert Brown on 7/12/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passConfirmField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FIRAuth.auth()?.currentUser) != nil {
            
        }
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        //Only allow segues to be called from respective action functions
        if(identifier == "register" || identifier == "backRegister"){
            return false;
        } else {
            return true;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.passField.text = ""
        self.passConfirmField.text = ""
        self.performSegueWithIdentifier("backRegister", sender: sender)
    }
    
    @IBAction func createAccountAction(sender: AnyObject) {
        let e = self.emailField.text
        let p = self.passField.text
        let pc = self.passConfirmField.text
        
        if(p != pc){
            self.passField.text = ""
            self.passConfirmField.text = ""
            let alertController = UIAlertController(title: "Oops!", message: "Those passwords don't match.", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            if(e == "" || p == ""){
                self.passField.text = ""
                self.passConfirmField.text = ""
                let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                FIRAuth.auth()?.createUserWithEmail(e!, password: p!, completion:
                    { (user, error) in
                        if error == nil {
                            self.passField.text = ""
                            self.passConfirmField.text = ""
                            FIRAuth.auth()?.signInWithEmail(e!, password: p!, completion: {(user, error) in
                            
                                if(error == nil){
                                    
                                } else {
                                    self.passField.text = ""
                                    self.passConfirmField.text = ""
                                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                                    alertController.addAction(defaultAction)
                                    
                                    self.presentViewController(alertController, animated: true, completion: nil)
                                }
                            })
                            self.performSegueWithIdentifier("register", sender: sender)
                            
                        } else {
                            self.passField.text = ""
                            self.passConfirmField.text = ""
                            let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                    })
            }
        }
    }
}
