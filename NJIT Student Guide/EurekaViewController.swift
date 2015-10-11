//
//  EurekaViewController.swift
//  NJIT Student Guide
//
//  Created by Mac on 10/7/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class EurekaViewController: UITableViewController {
     var profileNames = [String]()
    var item_images = [String]()
    var foundItemName = [String]()
    var itemDescription = [String]()
    
       override func viewDidLoad() {
        super.viewDidLoad()
        profileNames = ["Sam reily","Ungappa Patel","LavadiKabal Punda","Thevidya payan"]
        item_images = ["broadcast.png","Browse-Catalog-icon-1.png","building1X-1.png","PROFESSor.png"]
        foundItemName = ["en pool","un pool","elarum pool","thiruttu pool"]
        itemDescription = ["gdgdgdgdgdgd","gdgdgdgdgdgd","gdgdgdgdgdgd","gdgdgdgdgdgd"]
        
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
        
        return profileNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eurekaTableCell", forIndexPath: indexPath)
            as! EurekaTableControllerCell
        let row = indexPath.row
        cell.profile_name.text = profileNames[row]
        cell._image.image = UIImage(named: item_images[row])
        cell.found_item_name.text = foundItemName[row]
        cell.item_description.text = itemDescription[row]
        
       

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
