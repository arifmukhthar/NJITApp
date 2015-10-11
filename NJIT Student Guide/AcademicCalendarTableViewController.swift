//
//  AcademicCalendarTableViewController.swift
//  NJIT Student Guide
//
//  Created by Mac on 10/6/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class AcademicCalendarTableViewController: UITableViewController {

    var list = [String]()
    override func viewDidLoad() {
        getJSON("https://web.njit.edu/~rb454/academicyear.php")
        super.viewDidLoad()
        print(list)
        print("Button Pressed")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func getJSON(url: String){
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        
        do{
            let JSONresult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            
            for _ in JSONresult!{
                let dd = JSONresult![i]
                
                    list.append(dd["Year"] as! String)
                
                i = i+1
            }
            print(JSONresult)
            
        }catch let error as NSError{
            print(error)
        }
    }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AcademicCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = list[indexPath.row]


        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let destViewController = segue.destinationViewController as! AcademicListViewController
        
        destViewController.year = list[indexPath.row]
    }
    
}
