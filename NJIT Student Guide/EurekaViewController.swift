//
//  EurekaViewController.swift
//  NJIT Student Guide
//
//  Created by Mac on 10/7/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class EurekaViewController: UITableViewController {
    var item_images = [String]()
   
    var profileName = [String]()
    var itemDesc = [String]()
    var itemName = [String]()
    
       override func viewDidLoad() {
        
        getJSON("https://web.njit.edu/~ts336/LostAndFound.php")
        super.viewDidLoad()
        
        item_images = ["broadcast.png","Browse-Catalog-icon-1.png","building1X-1.png","PROFESSor.png"]
        
        
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
        
        return profileName.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eurekaTableCell", forIndexPath: indexPath)
            as! EurekaTableControllerCell
        let row = indexPath.row
        cell.profile_name.text = self.profileName[row]
        cell._image.image = UIImage(named: item_images[row])
        cell.found_item_name.text = self.itemName[row]
        cell.item_description.text = self.itemDesc[row]
        
       

        return cell
    }

    
    func getJSON(url: String) {
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        do {
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            for _ in jsonResult!
            {
                
                let data=jsonResult![i];
               
                self.profileName.append(data["userName"] as! String)
                self.itemDesc.append(data["itemDescription"] as! String)
                self.itemName.append(data["foundItemName"] as! String)
                
                i = i+1
                
            }
            print(jsonResult)
            
        } catch let error as NSError {
            print(error)
        }
    }

    
    
    
 


}
