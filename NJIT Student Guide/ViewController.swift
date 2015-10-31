//
//  ViewController.swift
//  todoapp
//
//  Created by Arif Mukhthar on 10/20/15.
//  Copyright © 2015 arif. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items  = [String]()
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addItem(sender: UIButton) {
        let newItem = textField.text
        items.append(newItem!)
        textField.resignFirstResponder()
        textField.text = ""
        print(items)
        tableView.reloadData()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(items)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    return items.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = UIColor.redColor()
        return cell
 }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedRow = tableView.cellForRowAtIndexPath(indexPath)!
        if selectedRow.accessoryType == UITableViewCellAccessoryType.None
        {
            selectedRow.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedRow.tintColor = UIColor.greenColor()
        }
        else if selectedRow.accessoryType == UITableViewCellAccessoryType.Checkmark
        {
            selectedRow.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let deletedRow = tableView.cellForRowAtIndexPath(indexPath)
        items.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        deletedRow?.accessoryType = UITableViewCellAccessoryType.None
        
        
        
    }
}

