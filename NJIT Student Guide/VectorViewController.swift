//
//  VectorViewController.swift
//  NJIT Student Guide
//
//  Created by user113232 on 10/22/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class VectorViewController: UITableViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad();
            getJSON("https://web.njit.edu/~ts336/arttitle.php")
        }
        
    @IBOutlet weak var searchBar: UISearchBar!
        var dataArr:[String]=[]
        var dataArrDate:[String]=[]
        var dataArrId:[String]=[]
        var strIndex:Int=0
        var searchActive : Bool = false
        var filtered:[String] = []
        var filteredDate:[String] = []
        var filteredId:[String] = []
    
    
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
        filtered = dataArr.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        }
        else {
            searchActive = true;
        
            filteredDate.removeAll()
            filteredId.removeAll()
            for item in filtered{
                let indDataArr=dataArr.indexOf(item)
                filteredDate.append(dataArrDate[indDataArr!])
                filteredId.append(dataArrId[indDataArr!])
            }
        }
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func getJSON(url: String) {
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            do {
                
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                var i = 0
                for _ in jsonResult!
                {
                    
                    let dd=jsonResult![i];
                    dataArr.append(dd["ArticleTitle"] as! String)
                    dataArrDate.append(dd["ArticleDate"] as! String)
                    dataArrId.append(dd["ArticleId"] as! String)
                    i = i+1
                    
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(searchActive) {
                return filtered.count
            }
            return dataArr.count;
            
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cellval = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath) as! VectorControllerCell
            var myImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://njitvector.com/wp-content/uploads/2015/10/Screen-Shot-2015-10-02-at-6.26.13-AM.png")!)!)
            cellval.ArticleImg.image=myImage
            
            if(searchActive && filtered.count != 0){
                cellval.ArticleTitle.text = filtered[indexPath.row]
                cellval.ArticleDate.text = filteredDate[indexPath.row]
            } else {
                
                cellval.ArticleTitle.text=dataArr[indexPath.item]
                cellval.ArticleDate.text=dataArrDate[indexPath.item]
            }
            
         
            return cellval
        }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        strIndex=indexPath.row
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let iVal = segue.destinationViewController as! VectorDetailControl

        if(searchActive  && filtered.count != 0){
            iVal.strVector = filteredId[indexPath.row]
        }
        else
        {
        iVal.strVector = dataArrId[indexPath.row]
        }
    }
    
    
}
