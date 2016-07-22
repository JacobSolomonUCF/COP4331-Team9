//
//  LoginView.swift
//  InventoryManagement
//
//  Created by Robert Brown on 7/12/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        // Transfer user back to login screen if not logged in
        if(FIRAuth.auth()?.currentUser == nil){
            self.performSegueWithIdentifier("logOutWelcome", sender: self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if(identifier == "logOutWelcome"){
            return false
        } else {
            return true
        }
    }

    
    @IBAction func logoutAction(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        self.performSegueWithIdentifier("logOutWelcome", sender: sender)
    }
}