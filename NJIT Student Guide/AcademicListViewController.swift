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
    var daydata = [String]()
    
    var infodatasearch = [String]()
    var yeardatasearch = [String]()
    var daydatasearch = [String]()
    var searchActive : Bool = false
    
    @IBOutlet var TblViewOutlet: UITableView!
    
    override func viewDidLoad() {
   
        getJSON("https://web.njit.edu/~rb454/academiccalendar.php")
      super.viewDidLoad()

    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        infodatasearch = infodata.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(infodatasearch.count == 0){
            searchActive = false;
        }
        else {
            searchActive = true;
            
            yeardatasearch.removeAll()
            daydatasearch.removeAll()
            for item in infodatasearch{
                let indDataArr=infodata.indexOf(item)
                yeardatasearch.append(yeardata[indDataArr!])
                daydatasearch.append(daydata[indDataArr!])
            }
        }
        self.tableView.reloadData()
        
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
                    self.daydata.append(dd["Day"] as! String)
                    i++
                    
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                });
                print(json)
            }catch _ as NSError{
                
            }
        })
        task1.resume()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infodata.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    9
        let cell  = tableView.dequeueReusableCellWithIdentifier("AcademicListCell", forIndexPath: indexPath) as! AcademicCell
        if(searchActive && infodatasearch.count != 0){
            cell.textViewInfo.text = self.infodatasearch[indexPath.row]
            cell.yearLabel.text = self.yeardatasearch[indexPath.row]
            cell.dayLabel.text = self.daydatasearch[indexPath.row]
        } else {
        cell.textViewInfo.text = self.infodata[indexPath.row]
        cell.yearLabel.text = self.yeardata[indexPath.row]
        cell.dayLabel.text = self.daydata[indexPath.row]
        }
        print(self.yeardata[indexPath.row])
        return cell
    }
    

}
