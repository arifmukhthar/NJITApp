
import UIKit
import Foundation
import MessageUI

class DateSelectAtheleticViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var toTimePicker: UIDatePicker!
    @IBOutlet weak var fromTimePicker: UIDatePicker!
    var to = String()
    var from = String()
    @IBOutlet weak var toTime: UILabel!
    @IBOutlet weak var fromTime: UILabel!
    var dateChoosed = String()
    var AthOrPro = String()
    var choice = String()
    
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
    
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        
        mailCompose.setToRecipients(["br.ragul@gmail.com"])
        mailCompose.setSubject("Reg: Appointment")
        if AthOrPro == "Atheletic Center"{
            
            mailCompose.setMessageBody("Hi Could you please set up an appointment from \(from) to \(to) on \(dateChoosed)", isHTML: false)
        }else{
            mailCompose.setMessageBody("Hi Professor, Could you please set up an appointment from \(from) to \(to) on \(dateChoosed)", isHTML: false)
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
    }

    @IBAction func toTimeChanged(sender: AnyObject) {
        toTimePicker.minimumDate = fromTimePicker.minimumDate
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        toTime.text = timeFormatter.stringFromDate(toTimePicker.date)
    }
}
