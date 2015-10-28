//
//  KnowYourProfessorDetails.swift
//  NJIT Student Guide
//
//  Created by Arif Mukhthar on 10/23/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class KnowYourProfessorDetails: UIViewController {
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var deptField: UILabel!
    @IBOutlet weak var addressField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var contactField: UILabel!
    @IBOutlet weak var hoursField: UILabel!
    @IBOutlet weak var descriptionField: UILabel!
    
    @IBOutlet weak var imgDet: UIImageView!
    
    
    
    var profName = String()
    var deptName = String()
    var address = String()
    var email = String()
    var contact = String()
    var hours = String()
    var desc = String()
    var url = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameField.text = profName
        deptField.text = deptName
        addressField.text = address
        emailField.text = email
        contactField.text = contact
        hoursField.text = hours
        descriptionField.text = desc
        let myImage =  UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
        imgDet.image=myImage
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
