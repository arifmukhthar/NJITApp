
import UIKit
import Foundation
import MessageUI

class DateSelectAtheleticViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var toTimePicker: UIDatePicker!
    @IBOutlet weak var fromTimePicker: UIDatePicker!
    var to = String()
    var from = String()
    var totime = NSDate()
    var fromtime = NSDate()
    @IBOutlet weak var toTime: UILabel!
    @IBOutlet weak var fromTime: UILabel!
    var dateChoosed = String()
    var AthOrPro = String()
    var choice = String()
    
    @IBOutlet weak var selectedOption: UILabel!
    @IBOutlet weak var date: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dateChoosed)
        date.text = dateChoosed
        if AthOrPro == "Athletic Center"{
        selectedOption.text = "\(choice) - Athletic Center"
        }else{
            selectedOption.text = "\(choice)"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        fromTimePicker.addTarget(self, action: "fromTimePickHandler", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func fromTimePickHandler(sender : UIDatePicker){
    }
    
    @IBAction func setAppointmentClicked(sender: AnyObject) {
        let a : NSComparisonResult = fromtime.compare(totime)
        switch a {
        case .OrderedAscending:
            let mailComposeViewController = configuredMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail(){
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            }
            else{
                self.showSendMailErrorAlert()
                print("No mail app present")
            }
            print("asc")
        case .OrderedDescending:
            let timeAlert = UIAlertView(title: "Time Conflict", message: "From time should be less than to time", delegate: self, cancelButtonTitle: "Ok")
            timeAlert.show()
            print("des")
        default:
            print("def")
        }
        
    
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        let temp1 : String = fromTime.text!
        let temp2 : String = toTime.text!
        mailCompose.setToRecipients(["br.ragul@gmail.com"])
        mailCompose.setSubject("Reg: Appointment")
        if AthOrPro == "Athletic Center"{
           
            mailCompose.setMessageBody("Hi Could you please set up an appointment from \(temp1) to \(temp2) on \(dateChoosed)", isHTML: false)
        }else{
            mailCompose.setMessageBody("Hi Professor, Could you please set up an appointment from \(temp1) to \(temp2) on \(dateChoosed)", isHTML: false)
        }
        
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
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        fromTime.text = timeFormatter.stringFromDate(fromTimePicker.date)
        fromtime = fromTimePicker.date
    }

    @IBAction func toTimeChanged(sender: UIDatePicker) {
        toTimePicker.minimumDate = fromTimePicker.minimumDate
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        toTime.text = timeFormatter.stringFromDate(toTimePicker.date)
        totime = toTimePicker.date
        
    
  
    }
}
