//
//  EurekaViewController.swift
//  NJIT Student Guide
//
//  Created by Mac on 10/7/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit
import MessageUI



class EurekaViewController: UITableViewController,MFMailComposeViewControllerDelegate{
    
    
    var item_images = [String]()
    
   
    var profileName = [String]()
    var itemDesc = [String]()
    var itemName = [String]()
    var userEmail = [String]()
    let rest = RestCall()
  
    
       override func viewDidLoad() {
        
        rest.getJSON("https://web.njit.edu/~ts336/LostAndFound.php")
        super.viewDidLoad()
        
        item_images = ["broadcast.png","Browse-Catalog-icon-1.png","building1X-1.png","PROFESSor.png","broadcast.png"]
        
        let PostButton : UIBarButtonItem = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.Plain, target: self, action:Selector("popToPost:"))
       
       
        self.navigationItem.rightBarButtonItem = PostButton
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rest.profileName.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eurekaTableCell", forIndexPath: indexPath)
            as! EurekaTableControllerCell
        let row = indexPath.row
        cell.profile_name.text = rest.profileName[row]
        cell._image.image = UIImage(named: item_images[row])
        cell.found_item_name.text = rest.itemName[row]
        cell.item_Description.text = rest.itemDesc[row]
        
        
       

        return cell
    }
    
   

    
    
    
    @IBAction func LostButtonSendEmail(sender: AnyObject) {
        
       
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Lost item in NJIT")
                
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Title", message: "Message",preferredStyle:.Alert)
        
        let okAction = UIAlertAction(title:"OK",style:.Cancel){(action) in }
        
        sendMailErrorAlert.addAction(okAction)
        
        self.presentViewController(sendMailErrorAlert, animated: true){
                
            }
    }
    
    
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
 
    func popToPost(sender: UIBarButtonItem!) {
        self.performSegueWithIdentifier("toPost", sender: self)
    }

}




