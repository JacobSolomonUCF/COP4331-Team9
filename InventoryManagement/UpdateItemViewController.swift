//
//  UpdateItemViewController.swift
//  InventoryManagement
//
//  Created by Robert Brown on 7/21/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseDatabase

class UpdateItemViewController: UIViewController, UITextFieldDelegate {

    var prevItemName: String!
    var prevItemNumber: String!
    var prevItemQuantity: String!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemNumber: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemName.text = prevItemName
        self.itemNumber.text = prevItemNumber
        self.itemQuantity.text = prevItemQuantity
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

    @IBAction func updateButtonTapped(sender: AnyObject) {
        
        if(self.itemName.text == "" || self.itemNumber.text == "" || self.itemQuantity.text == ""){
            let alertController = UIAlertController(title: "Oops!", message: "Please enter a valid Item Name/Number/Quantity", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if(Int(self.itemNumber.text!) == nil || Int(self.itemQuantity.text!) == nil){
            let alertController = UIAlertController(title: "Oops!", message: "Please enter only numbers for Number/Quantity", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }else {
            
            self.updateButton.enabled = false
            self.cancelButton.enabled = false
            let ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()!.currentUser!.uid;
            ref.child("items/\(userID)").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                var canUpdate: Bool = true
                

                let children = snapshot.children
                
                for _ in 0..<snapshot.childrenCount{
                    let child = children.nextObject()
                    
                    let childSnapshot = snapshot.childSnapshotForPath(child!.key)
                    let number = childSnapshot.value!["itemNumber"] as! String
                    if(number != self.prevItemNumber && number == self.itemNumber.text!){
                        canUpdate = false
                        let alertController = UIAlertController(title: "Oops!", message: "Item #" + self.itemNumber.text! + " already exists", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        break
                    }

                }

                
                if(canUpdate){
                    ref.child("items/\(userID)/\(self.prevItemNumber)").removeValue()
                    let post = ["itemName": self.itemName.text! as NSString,
                        "itemNumber": self.itemNumber.text! as NSString,
                        "itemQuantity": self.itemQuantity.text! as NSString]
                    
                    let childUpdates = ["/items/\(userID)/\(self.itemNumber.text!)": post,]
                    ref.updateChildValues(childUpdates, withCompletionBlock: {_,_ in 
                        let alertController = UIAlertController(title: "Complete!", message: "Item #" + self.itemNumber.text! + " has been updated.", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        self.updateButton.enabled = true
                        self.cancelButton.enabled = true
                    })
                } else {
                    self.updateButton.enabled = true
                    self.cancelButton.enabled = true
                }
            })
        }
    }
    
}