//
//  addItemController.swift
//  InventoryManagement
//
//  Created by Jacob Solomon on 7/14/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit

class addItemController: UIViewController {
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemNumber: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func additemPressed(sender: UIButton) {
        
        if (self.itemName.text == " " || self.itemNumber.text == " " || self.itemQuantity == " ") {
            let alertController = UIAlertController(title: "Oops!", message: "Pleae enter an Item name, number, and quantity", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
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
