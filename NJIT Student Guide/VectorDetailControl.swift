//
//  VectorDetailControl.swift
//  NJIT Student Guide
//
//  Created by user113232 on 10/23/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class VectorDetailControl: UIViewController {

    
    
    @IBOutlet weak var lblVectorDet: UILabel!
    var strVector:String!
    override func viewDidLoad() {
        super.viewDidLoad();
        lblVectorDet.text = strVector
    }
}
