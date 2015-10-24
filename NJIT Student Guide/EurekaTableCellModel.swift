//
//  EurekaTableCellModel.swift
//  NJIT Student Guide
//
//  Created by Mac on 10/7/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation
class EurekaTableCellModel {
    
     var profileName = [String]()
    var item_images = [String]()
    var foundItemName = [String]()
    var itemDescription = [String]()
   
    func EurekaTableCellModel() {
        
    }
    
    func getProfileName(index: Int) ->String! {
       
        return profileName[index]
        
    }
    func getFoundItemName(index: Int) ->String! {
        
        return foundItemName[index]
        
    }
    func getItemDescription(index: Int) ->String! {
        
        return itemDescription[index]
        
    }
    func getItemImages(index: Int) ->String! {
        
        return item_images[index]
        
    }
    func setProfileName() {
        
    }
    func setFoundItemName() {
        
    }
    func setItemDescription() {
        
    }
    func setItemImages() {
        
    }
    func get_data_from_url()
    {
       // let	session = NSURLSession.sharedSession()
       /* let url = NSURL('https://web.njit.edu/~ts336/LostAndFound.php')
        var task = session.dataTaskWithURL(url!){
            	(data,response,errror) -> Void in
            if( error != null) {
                    print(error.localizedDescription)
            }
                    else {
                    
            }
        }
        task.resume()
        */
        }
}
