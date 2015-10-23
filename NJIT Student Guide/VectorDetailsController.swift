//
//  VectorDetailsController.swift
//  NJIT Student Guide
//
//  Created by user113232 on 10/22/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class VectorDetailsController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad();
        getJSON("https://web.njit.edu/~ts336/arttitle.php")
    }
    
    var dataArr:[String]=[]
    var dataArrDate:[String]=[]
    var intRow=0
    
    func getJSON(url: String) {
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        do {
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            for _ in jsonResult!
            {
                
                let dd=jsonResult![i];                    dataArr.append(dd["ArticleTitle"] as! String)
                dataArrDate.append(dd["ArticleDate"] as! String)
                i = i+1
                
            }
            print(jsonResult)
            
        } catch let error as NSError {
            print(error)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellval = tableView.dequeueReusableCellWithIdentifier("DetailsCell", forIndexPath: indexPath) 
        
        if(intRow==0){
        cellval.textLabel?.text=dataArr[intRow]
        }
        else
        {
            cellval.textLabel?.text=dataArr[intRow]
            
        }
        return cellval
        
    }

    
}
