//
//  VectorDetailControl.swift
//  NJIT Student Guide
//
//  Created by user113232 on 10/23/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class VectorDetailControl: UIViewController {

    
    @IBOutlet weak var txtVector: UITextView!
    
    var strVector:String!
    var dataArrDesc = String()
    
    override func viewDidLoad() {
        dataArrDesc = "Some Shit"
        super.viewDidLoad();
      //  txtVector.text = strVector
        getJSON("https://web.njit.edu/~ts336/artDesc.php")
        
    }
    
    func getJSON(url:String){
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        let params = "data='\(strVector)'"
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task1 = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data,response, error -> Void in
            
            do{
                var i = 0
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                //print(json)
                for _ in json! {
                    let dd = json![i]
                    self.dataArrDesc = dd["ArticleDesc"] as! String
                    
                    i++
                    
                }
                

                dispatch_async(dispatch_get_main_queue(), {
                    self.txtVector.text=self.dataArrDesc
                    print(self.dataArrDesc)
                    self.txtVector.reloadInputViews()
                });
                
            }catch _ as NSError{
                
            }
        })
        task1.resume()
        
    }
}
