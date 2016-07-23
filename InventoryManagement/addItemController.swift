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

class addItemController: UIViewController, UITextFieldDelegate {
    

    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemNumber: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        
        self.hideKeyboardWhenTappedAround()
        self.itemName.delegate = self
        self.itemNumber.delegate = self
        self.itemQuantity.delegate = self
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addPressed(sender: UIButton) {
        
        if(self.itemName.text! == "" || self.itemNumber.text == "" || self.itemQuantity.text == "" ){
            let alertController = UIAlertController(title: "Oops!", message: "Please enter a valid Item Name/Number/Quantity", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else if(Int(self.itemNumber.text!) == nil || Int(self.itemQuantity.text!) == nil){
            let alertController = UIAlertController(title: "Oops!", message: "Please enter only numbers for Number/Quantity", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
        
            self.presentViewController(alertController, animated: true, completion: nil)
        } else{
        
            self.addButton.enabled = false
            self.cancelButton.enabled = false
            let rootRef = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()!.currentUser!.uid;      //USER ID is the key for the database
            let key = self.itemNumber.text! as NSString
            
            rootRef.child("items/\(userID)").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                var canUpdate: Bool = true
                
                
                let children = snapshot.children
                
                for _ in 0..<snapshot.childrenCount{
                    let child = children.nextObject()
                    
                    let childSnapshot = snapshot.childSnapshotForPath(child!.key)
                    let number = childSnapshot.value!["itemNumber"] as! String
                    if(number == self.itemNumber.text!){
                        canUpdate = false
                        let alertController = UIAlertController(title: "Oops!", message: "Item #" + self.itemNumber.text! + " already exists", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        break
                    }
                    
                }
                
                
                if(canUpdate){
                    let post = ["itemName": self.itemName.text! as NSString,
                        "itemNumber": self.itemNumber.text! as NSString,
                        "itemQuantity": self.itemQuantity.text! as NSString]
                    
                    let childUpdates = ["/items/\(userID)/\(key)": post,]
                    rootRef.updateChildValues(childUpdates, withCompletionBlock: {_,_ in
                        self.addButton.enabled = true
                        self.cancelButton.enabled = true
                    })
                    
                    let alertController = UIAlertController(title: "Complete!", message: "Item #" + self.itemNumber.text! + " added successfully", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    self.itemName.text = ""
                    self.itemNumber.text = ""
                    self.itemQuantity.text = ""
                } else {
                    self.addButton.enabled = true
                    self.cancelButton.enabled = true
                }
            })
        


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
