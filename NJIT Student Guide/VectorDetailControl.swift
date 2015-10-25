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
    
    @IBOutlet weak var btnShare: UIButton!
    var strVector:String!
    var dataArrDesc = String()
    var dataArrTitle = String()
    
    @IBOutlet weak var lblArtTitle: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        getJSON("https://web.njit.edu/~ts336/artDesc.php")
        
    }
    

    
    @IBAction func btnShare(sender: UIButton) {
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
                for _ in json! {
                    let dd = json![i]
                    self.dataArrDesc = dd["ArticleDesc"] as! String
                    self.dataArrTitle = dd["ArticleTitle"] as! String
                    
                    i++
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.txtVector.text=self.dataArrDesc
                    self.lblArtTitle.text=self.dataArrTitle
                    self.txtVector.reloadInputViews()
                    self.lblArtTitle.reloadInputViews()
                });
                
            }catch _ as NSError{
                
            }
        })
        task1.resume()
        
    }
}
