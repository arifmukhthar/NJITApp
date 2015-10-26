//
//  RestCall.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/24/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation
class RestCall {
    
    var profileName = [String]()
    var itemDesc = [String]()
    var itemName = [String]()
    var userEmail = [String]()
    
    func getJSON(url: String) {
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        do {
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            for _ in jsonResult!
            {
                
                let data=jsonResult![i];
                
                self.profileName.append(data["userName"] as! String)
                self.itemDesc.append(data["itemDescription"] as! String)
                self.itemName.append(data["foundItemName"] as! String)
                self.userEmail.append(data["userEmail"] as! String)
                i = i+1
                
            }
            print(jsonResult)
            
        } catch let error as NSError {
            print(error)
}
}
}