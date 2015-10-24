//
//  RestCall.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/14/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation
class RestCall {
    var profileName = [String]()
    var itemDesc = [String]()
    var itemName = [String]()
    
    func updateLostAndFound() {
        let getEndPoint: String = "https://web.njit.edu/~ts336/LostAndFound.php"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: getEndPoint)!
        session.dataTaskWithURL(url,completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
          guard let realResponse = response as? NSHTTPURLResponse where
            realResponse.statusCode == 200 else {
                return
            }
            
            do {
                let retrievedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                var i = 0
                
                for _ in retrievedData!{
                    let data = retrievedData![i]
                    self.profileName.append(data["userName"] as! String)
                    self.itemDesc.append(data["itemDescription"] as! String)
                    self.itemName.append(data["foundItemName"] as! String)
                    i=i+1
                }
               
                
            }
            catch{
                   print("something happened")
                }
            
            
        }).resume()
    }
    func printItems(){
        self.updateLostAndFound()
        if(profileName.isEmpty){
            print("Empty")
        }
        else {
        for item in profileName {
            print("\(item)")
        }
        }
    }
}
    