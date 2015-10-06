//
//  TestViewController.swift
//  NJIT Student Guide
//
//  Created by user113255 on 9/27/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class SetAppoinmentAtheleticViewController: UIViewController {
    
    //@IBOutlet weak var myLabel: UILabel!
    var scheduleChoice = String()
    var optionChoosed = String()
    var datetime = String()
    @IBOutlet weak var datePick: UIDatePicker!
    
    @IBAction func btnClick(sender: UIButton) {
        //myLabel.text = datetime
    }
    
    override func viewDidLoad() {
        //myLabel.text = "Schedule Choice: \(scheduleChoice) Option Choosed : \(optionChoosed)"
        print(scheduleChoice)
        print(optionChoosed)
        datePick.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        }
    
    
    func handleDatePicker(sender : UIDatePicker){
        
        datePick.minimumDate = NSDate()
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        datetime = dateformatter.stringFromDate(datePick.date)
        //myLabel.text = datetime

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! DateSelectAtheleticViewController
        
        destViewController.dateChoosed = datetime
    }
    
   
    
}
