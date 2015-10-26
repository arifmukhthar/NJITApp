//
//  ContactViewController.swift
//  NJIT Student Guide
//
//  Created by user113232 on 10/24/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON("https://web.njit.edu/~ts336/contacts.php")
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var dataArrDept:[String]=[]
    var dataArrName:[String]=[]
    var dataArrMail:[String]=[]
    var dataArrPhone:[String]=[]
    var dataArrCall:[String]=[]
    
    var strIndex:Int=0
    var searchActive : Bool = false
    var filtered:[String] = []
    var filteredName:[String] = []
    var filteredMail:[String] = []
    var filteredPhone:[String] = []
    var filteredCall:[String] = []
    
    
    
    
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
        filtered = dataArrDept.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            filteredName.removeAll()
            filteredPhone.removeAll()
            filteredMail.removeAll()
            filteredCall.removeAll()
            for item in filtered{
                let indDataArr=dataArrDept.indexOf(item)
                filteredName.append(dataArrName[indDataArr!])
                filteredPhone.append(dataArrPhone[indDataArr!])
                filteredMail.append(dataArrMail[indDataArr!])
                filteredCall.append(dataArrCall[indDataArr!])
                
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
                dataArrDept.append(dd["Department"] as! String)
                dataArrName.append(dd["ContactPerson"] as! String)
                dataArrMail.append(dd["ContactEMail"] as! String)
                dataArrPhone.append(dd["ContactNumber"] as! String)
                dataArrCall.append(dd["CallContact"] as! String)
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
        return dataArrDept.count;
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    //    let cellval = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCellControl
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        var strPhone = ""
        
        
        
        if(searchActive){
            searchBar.resignFirstResponder()
            strPhone = filteredCall[indexPath.row]
        }
        else
        {
            strPhone = dataArrCall[indexPath.row]
        }
        
        var myNSString = strPhone as NSString
        
        myNSString = myNSString.substringWithRange(NSRange(location: 0, length: 10))
        strPhone=(myNSString as String)
        
        
        strPhone="tel://"+strPhone
        print(strPhone)
        let url:NSURL = NSURL(string: strPhone)!
        UIApplication.sharedApplication().openURL(url)
        
        }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellval = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCellControl
        
        if(searchActive){
            cellval.lblContactDept.text = filtered[indexPath.row]
            cellval.lblContactName.text = filteredName[indexPath.row]
            cellval.lblContactPhone.text = filteredPhone[indexPath.row]
            cellval.lblContactMail.text = filteredMail[indexPath.row]
        } else {
            
            cellval.lblContactDept.text=dataArrDept[indexPath.item]
            cellval.lblContactName.text=dataArrName[indexPath.item]
            cellval.lblContactPhone.text=dataArrPhone[indexPath.item]
            cellval.lblContactMail.text=dataArrMail[indexPath.item]
        }
        
        return cellval
    }

    
    
}
