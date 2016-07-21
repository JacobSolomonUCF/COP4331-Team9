//
//  addItemController.swift
//  InventoryManagement
//
//  Created by Jacob Solomon on 7/14/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseDatabase

class addItemController: UIViewController {
    

    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemNumber: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addPressed(sender: UIButton) {
        
        if(self.itemName.text == "" || self.itemNumber.text == "" || self.itemQuantity.text == "" ){
            let alertController = UIAlertController(title: "Oops!", message: "Please enter a valid Item Name/Number/Quantity", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else{
        
            let rootRef = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()!.currentUser!.uid;      //USER ID is the key for the database
            let key = itemNumber.text! as NSString
        
            let post = ["itemName": self.itemName.text! as NSString,
                        "itemNumber": self.itemNumber.text! as NSString,
                        "itemQuantity": self.itemQuantity.text! as NSString]
            
            let childUpdates = ["/items/\(userID)/\(key)": post,]
            rootRef.updateChildValues(childUpdates)
            
            
        

        }
    
    }
    
    //Testing function
    @IBAction func TEST(sender: UIButton) {
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()!.currentUser!.uid;
        ref.child("/items/\(userID)/1").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            let test = snapshot.value!["itemName"] as! String
            print(test)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        let query = ref.child("/items/\(userID)").queryOrderedByChild("itemName");
        print(query)
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
