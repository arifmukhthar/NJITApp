//
//  PostLostItemViewController.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/25/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class PostLostItemViewController: UIViewController {

    @IBOutlet weak var itemDesc: UITextField!
    @IBOutlet weak var userEmail: UITextField!

    @IBOutlet weak var ItemName: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Save(sender: AnyObject) {
        postJSON(userName.text!,useremail: userEmail.text!,itemname: ItemName.text!,itemdesc: itemDesc.text!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func postJSON(username: String!,useremail: String!,itemname: String!,itemdesc: String!) {
        let myUrl = NSURL(string: "https://web.njit.edu/~ss2773/postlostfound.php")
        let request = NSMutableURLRequest(URL:myUrl!)
        request.HTTPMethod = "POST"
        let postString = "username =\(username)&useremail=\(useremail)&itemname=\(itemname)&itemdesc=\(itemdesc)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler: {data,response, error ->
            Void in
            print("data: \(data)")

       
        })
        task.resume()
        
    }

    }
