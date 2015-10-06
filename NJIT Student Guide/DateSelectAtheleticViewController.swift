
import UIKit
import Foundation
import MessageUI

class DateSelectAtheleticViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var toTimePicker: UIDatePicker!
    @IBOutlet weak var fromTimePicker: UIDatePicker!
    var to : NSDate!
    var from : NSDate!
    @IBOutlet weak var toTime: UILabel!
    @IBOutlet weak var fromTime: UILabel!
    var dateChoosed = String()
    
    @IBOutlet weak var date: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dateChoosed)
        date.text = dateChoosed

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        fromTimePicker.addTarget(self, action: "fromTimePickHandler", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func fromTimePickHandler(sender : UIDatePicker){
    }
    
    @IBAction func setAppointmentClicked(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        }
        else{
            self.showSendMailErrorAlert()
            print("No mail app present")
        }
        /*print(from)
        print(to)
        var order = NSCalendar.currentCalendar().compareDate(from, toDate: to, toUnitGranularity: .Day)
        
        switch order {
        case .OrderedAscending:
            print("Ascending")
        case .OrderedDescending:
            print("Descending")
        case .OrderedSame:
            print("Same")
        default:
            print("Default")
        }*/
    
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        
        mailCompose.setToRecipients(["br.ragul@gmail.com"])
        mailCompose.setSubject("Appoinment Setter Test")
        mailCompose.setMessageBody("This is an appointment setter test mail. Please ignore", isHTML: false)
        
        return mailCompose
    }
    
    func showSendMailErrorAlert(){
        let mailAlert = UIAlertView(title: "Can't send mail", message: "No mail app in your phone", delegate: self, cancelButtonTitle: "Ok")
        mailAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func fromTImeChanged(sender: UIDatePicker) {
        from = fromTimePicker.date
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        fromTime.text = timeFormatter.stringFromDate(fromTimePicker.date)
    }

    @IBAction func toTimeChanged(sender: AnyObject) {
        to = toTimePicker.date
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        toTime.text = timeFormatter.stringFromDate(toTimePicker.date)
    }
}
