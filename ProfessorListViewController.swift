//
//  ProfessorListViewController.swift
//  NJIT Student Guide
//
//  Created by Ishani Chatterjee on 10/25/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class ProfessorListViewController: UITableViewController {
    
    var scheduleChoice = String()
    var optionChoosed = String()
    var list = [String]()
    
    override func viewDidLoad() {
        getJSON("https://web.njit.edu/~rb454/professorlist.php")
        super.viewDidLoad()
        print("Schedule Choice \(scheduleChoice) option choosed \(optionChoosed)")
        
    }
    
    func getJSON(url:String){
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        let params = "data='\(optionChoosed)'"
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task1 = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data,response, error -> Void in
            print("data: \(data)")
            
            do{
                var i = 0
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                //print(json)
                for _ in json! {
                    let dd = json![i]
                    self.list.append(dd["Name"] as! String)
                    i++
                    
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                });
                
            }catch _ as NSError{
                
            }
        })
        task1.resume()
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ProfListCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        let destViewController = segue.destinationViewController as! SetAppoinmentAtheleticViewController
        
        destViewController.scheduleChoice = scheduleChoice
        
        destViewController.optionChoosed = list[indexPath.row]
    }
    
    
}
