//
//  KnowYourProfessorController.swift
//  NJIT Student Guide
//
//  Created by Arif Mukhthar on 10/23/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class KnowYourProfessorController: UITableViewController{
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    var profName = [String]()
    var deptName = [String]()
    var address = [String]()
    var email = [String]()
    var contact = [String]()
    var hours = [String]()
    var desc = [String]()
   // var collegeID = [String]()
    
    
    var filteredprofName = [String]()
    var filtereddeptName = [String]()
    var filteredaddress = [String]()
    var filteredemail = [String]()
    var filteredcontact = [String]()
    var filteredhours = [String]()
    var filtereddesc = [String]()
   // var filteredcollegeID = [String]()

    var searchActive : Bool = false
    var filtered:[String] = []
    
    
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
        searchBar.resignFirstResponder()
       
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON("https://web.njit.edu/~au56/kyp.php")
      
       print(searchBar.selectedScopeButtonIndex)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive)
        {
            return filtered.count
            
        }
        else{
            
            return profName.count
        }
    }
    
    
    
    func getJSON(url: String){
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        
        do{
            let JSONresult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            
            for _ in JSONresult!{
                let resultString = JSONresult![i]
                
                profName.append(resultString["name"] as! String)
                deptName.append(resultString["department"] as! String)
                address.append(resultString["address"] as! String)
                email.append(resultString["email"] as! String)
                contact.append(resultString["contact"] as! String)
                hours.append(resultString["hours"] as! String)
                desc.append(resultString["description"] as! String)
             //   collegeID.append(resultString["collegeid"] as! String)
                
                i++
            }
            
        }catch let error as NSError{
            print(error)
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = profName.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;

        } else {
            searchActive = true;
            
            filteredaddress.removeAll()
            filteredcontact.removeAll()
            filtereddeptName.removeAll()
            filtereddesc.removeAll()
            filteredemail.removeAll()
            filteredhours.removeAll()
            filteredprofName.removeAll()
          //  filteredcollegeID.removeAll()
            for item in filtered{
                let inOriginalList = profName.indexOf(item)
                filteredprofName.append(profName[inOriginalList!])
                filteredhours.append(hours[inOriginalList!])
                filteredemail.append(email[inOriginalList!])
                filtereddesc.append(desc[inOriginalList!])
                filtereddeptName.append(deptName[inOriginalList!])
                filteredcontact.append(contact[inOriginalList!])
                filteredaddress.append(address[inOriginalList!])
        //        filteredcollegeID.append(collegeID[inOriginalList!])
            }
        }
      
        self.tableView.reloadData()
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
       
        
        let destViewController = segue.destinationViewController as! KnowYourProfessorDetails
        
        if(searchActive && filtered.count != 0)
        {
            destViewController.profName = filteredprofName[indexPath.row]
            destViewController.deptName = filtereddeptName[indexPath.row]
            destViewController.address = filteredaddress[indexPath.row]
            destViewController.email = filteredemail[indexPath.row]
            destViewController.contact = filteredcontact[indexPath.row]
            destViewController.hours = filteredhours[indexPath.row]
            destViewController.desc = filtereddesc[indexPath.row]
        }
        else
        {
        destViewController.profName = profName[indexPath.row]
        destViewController.deptName = deptName[indexPath.row]
        destViewController.address = address[indexPath.row]
        destViewController.email = email[indexPath.row]
        destViewController.contact = contact[indexPath.row]
        destViewController.hours = hours[indexPath.row]
        destViewController.desc = desc[indexPath.row]
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Cell = self.tableView.dequeueReusableCellWithIdentifier("Cello", forIndexPath: indexPath) as UITableViewCell
        
        if(searchActive && filtered.count != 0){
            Cell.textLabel?.text = filtered[indexPath.row]
            Cell.textLabel?.textColor = UIColor.whiteColor()
            
        } else {
            Cell.textLabel?.text = profName[indexPath.row]
            Cell.textLabel?.textColor = UIColor.whiteColor()
        }
        
        
        return Cell
        
    }
    
}
