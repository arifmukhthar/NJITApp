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
      var infodata = [String]()
    var yeardata = [String]()
    
    @IBOutlet var TblViewOutlet: UITableView!
    
    override func viewDidLoad() {
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        
        getJSON("https://web.njit.edu/~rb454/academiccalendar.php")
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.TblViewOutlet.reloadData()
        })
     
        super.viewDidLoad()
      
        TblViewOutlet.reloadData()
         //print(infodata)

    }
    
    func refresh(sender:AnyObject?){
        TblViewOutlet.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getJSON(url:String){
    
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        let params = "data='\(year)'"
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task1 = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data,response, error -> Void in
            print("data: \(data)")
        
            do{
                var i = 0
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                //print(json)
                for _ in json! {
                    let dd = json![i]
                    self.infodata.append(dd["Information"] as! String)
                    self.yeardata.append(dd["Date"] as! String)
                    i++
                    
                }
                self.TblViewOutlet.reloadData()
                
            }catch _ as NSError{
                
            }

        
        })
        
       
        task1.resume()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
                    }
        task.resume()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infodata.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell  = tableView.dequeueReusableCellWithIdentifier("AcademicListCell", forIndexPath: indexPath) as! AcademicCell
        cell.textViewInfo.text = self.infodata[indexPath.row]
        cell.yearLabel.text = self.yeardata[indexPath.row]
        print(self.yeardata[indexPath.row])
        return cell
    }
    

}
