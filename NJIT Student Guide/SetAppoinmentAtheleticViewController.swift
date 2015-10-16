
import UIKit

class SetAppoinmentAtheleticViewController: UIViewController {
    
    var scheduleChoice = String()
    var optionChoosed = String()
    var datetimechoosed = String()
    @IBOutlet weak var datePick: UIDatePicker!
    
    override func viewDidLoad() {
        print(scheduleChoice)
        print(optionChoosed)
        
         let tempDate   = NSDate()
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        datetimechoosed = dateformatter.stringFromDate(tempDate)
        
        datePick.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        }
    
    
    func handleDatePicker(sender : UIDatePicker){
        
        datePick.minimumDate = NSDate()
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        datetimechoosed = dateformatter.stringFromDate(datePick.date)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = segue.destinationViewController as! DateSelectAtheleticViewController
        
        destViewController.dateChoosed = datetimechoosed
        destViewController.AthOrPro = scheduleChoice
        destViewController.choice = optionChoosed
    }
    
   
    
}
