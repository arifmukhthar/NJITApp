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
    
    @IBOutlet weak var emailField: UILabel!
    
    
    
    var profName = String()
    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //detailImage.image = UIImage(named: imageDetail)
        
        nameField.text = profName
        emailField.text = email
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
