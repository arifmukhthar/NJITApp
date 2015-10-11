//
//  AcademicListViewController.swift
//  NJIT Student Guide
//
//  Created by Mac on 10/10/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class AcademicListViewController: UITableViewController {
    
    var year = String()
      var list = [String]()
    override func viewDidLoad() {
        
       // print(year)
        
        getJSON("https://web.njit.edu/~rb454/academiccalendar.php")
       
        super.viewDidLoad()
         print(list)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getJSON(url:String){
        
        let url : NSURL = NSURL(string:url)!
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        let bodyData = "data='\(year)'"
        request.HTTPMethod = "POST"
        
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                print(data)
                do{
                    let JSONresult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                    var i = 0
                    
                    for _ in JSONresult!{
                        let dd = JSONresult![i]
                        
                        self.list.append(dd["Information"] as! String)
                        
                        i = i+1
                    }
                    //print(JSONresult)
                    
                }catch let error as NSError{
                    print(error)
                }
               // print(self.list)
                
        }

        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AcademicListCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.list[indexPath.row]
        return cell
    }
    

}
