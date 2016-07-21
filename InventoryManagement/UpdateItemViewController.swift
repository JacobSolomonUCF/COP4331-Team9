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

class UpdateItemViewController: UIViewController {

    @IBOutlet weak var viewNameLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemNumber: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    
    @IBOutlet weak var saveEditButton: UIButton!
    @IBOutlet weak var cancelReturnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveEditButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func cancelReturnButtonTapped(sender: AnyObject) {
        
    }
}