//
//  KnowYourProfessorController.swift
//  NJIT Student Guide
//
//  Created by Arif Mukhthar on 10/23/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class KnowYourProfessorController: UITableViewController{
   
    var profList = [String]()
    var email = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON("https://web.njit.edu/~au56/professor.php")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        let Cell = self.tableView.dequeueReusableCellWithIdentifier("Cello", forIndexPath: indexPath) as UITableViewCell
        Cell.textLabel?.text = profList[indexPath.row]
      
        return Cell
    }
    
    func getJSON(url: String){
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        
        do{
            let JSONresult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            
            for _ in JSONresult!{
                let resultString = JSONresult![i]
                    profList.append(resultString["name"] as! String)
                    email.append(resultString["email"] as! String)
                i++
            }
            print(JSONresult)
            
        }catch let error as NSError{
            print(error)
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        let destViewController = segue.destinationViewController as! KnowYourProfessorDetails
        
        
        destViewController.profName = profList[indexPath.row]
        destViewController.email = email[indexPath.row]
        
    }
    
   /* override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! KnowYourProfessorDetails
        detailVC.profName = profList[indexPath.row]
        detailVC.email = email[indexPath.row]
        
        self.presentViewController(detailVC, animated: true, completion: nil)

    }*/
    
}
