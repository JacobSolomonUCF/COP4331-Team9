//
//  InventoryTableViewController.swift
//  InventoryManagement
//
//  Created by Robert Brown on 7/20/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class InventoryTableViewController: UITableViewController {
    
    //MARK: Properties

    @IBOutlet var inventoryTableView: UITableView!
    @IBOutlet weak var backView: UIView!
    var parent: ContainerViewController!
    
    var items = [Item]();
    
    struct Item{
        var name: String;
        var number: String;
        var quantity: String;
    };

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        self.tableView.allowsSelectionDuringEditing = true
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.inventoryTableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadItems()
        self.inventoryTableView.tableFooterView = UIView();
    }
    
    
    func sortItemsAlphabetically(){
        self.items.sortInPlace{$0.name.lowercaseString < $1.name.lowercaseString}
        self.inventoryTableView.reloadData()
    }
    
    func sortItemsByNumber(){
        self.items.sortInPlace{Int($0.number) < Int($1.number)}
        self.inventoryTableView.reloadData()
    }
    
    
    func loadItems(){
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()!.currentUser!.uid;
        ref.child("items/\(userID)").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
        
            let children = snapshot.children
            
            for _ in 0..<snapshot.childrenCount{
                let child = children.nextObject()
                
                let childSnapshot = snapshot.childSnapshotForPath(child!.key)
                let name = childSnapshot.value!["itemName"] as! String
                let number = childSnapshot.value!["itemNumber"] as! String
                let quantity = childSnapshot.value!["itemQuantity"] as! String
                let newItem = Item(name: name, number: number, quantity: quantity)

                self.items.append(newItem)
            }
            self.sortItemsByNumber()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "InventoryTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InventoryTableViewCell
        
        let item = self.items[indexPath.row]
        cell.nameLabel.text = item.name
        cell.numberLabel.text = item.number
        cell.quantityLabel.text = item.quantity
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()!.currentUser!.uid;
            let itemNumber = (tableView.cellForRowAtIndexPath(indexPath) as! InventoryTableViewCell).numberLabel!.text!
            ref.child("items/\(userID)/\(itemNumber)").removeValueWithCompletionBlock({ _,_ in
                self.items.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })

        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
     

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("test")
        _ = tableView.indexPathForSelectedRow!
        if let _ = tableView.cellForRowAtIndexPath(indexPath) {
            self.performSegueWithIdentifier("updateItemSegue", sender: self)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "updateItemSegue"){
            if let destination = segue.destinationViewController as? UpdateItemViewController {
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!) as! InventoryTableViewCell
                destination.prevItemName = cell.nameLabel.text!
                destination.prevItemNumber = cell.numberLabel.text!
                destination.prevItemQuantity = cell.quantityLabel.text!
            }
        }
    }

    
}
