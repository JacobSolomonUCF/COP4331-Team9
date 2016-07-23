//
//  ContainerViewController.swift
//  InventoryManagement
//
//  Created by Robert Brown on 7/23/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit
import Firebase

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var sortButton: UIButton!
    var child: InventoryTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortButton.setTitle("Sort By Name", forState: UIControlState.Normal)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "embedSegue"){
            if let destination = segue.destinationViewController as? InventoryTableViewController {
                destination.parent = self;
                self.child = destination
            }
        }
    }
    
    
    @IBAction func sortButtonTapped(sender: AnyObject) {
        if(self.sortButton.titleLabel!.text == "Sort By Name"){
            self.child.sortItemsAlphabetically()
            self.sortButton.setTitle("Sort By Number", forState: UIControlState.Normal)
        } else {
            self.child.sortItemsByNumber()
            self.sortButton.setTitle("Sort By Name", forState: UIControlState.Normal)
        }
    }

}