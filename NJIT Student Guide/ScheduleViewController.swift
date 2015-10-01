

import UIKit

class ScheduleViewController: UITableViewController {
    
    var appoinmentList = [String]()
    
    var secondArray = [ScheduleTable]()
    
    var temp = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appoinmentList = [("Atheletic Center"),("Professors")]
        
        secondArray = [ScheduleTable(SecondTitle :["Table Tennis","Tennis","Volleyball","Badmiton","Bowling","Football"]),
                        ScheduleTable(SecondTitle :["Prof. Borcea","Prof. Oria","Prof. Geller","Prof Roshan","Prof Neamtiu","Prof Nassimi"])]
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appoinmentList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        //let list = appoinmentList[indexPath.row]
        cell.textLabel?.text = appoinmentList[indexPath.row]
        return cell
    }

	
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        var DestViewController = segue.destinationViewController as! AtheleticViewController
        
        var secondArrayTwo : ScheduleTable
        
        secondArrayTwo = secondArray[indexPath.row]
        
        DestViewController.list = secondArrayTwo.SecondTitle
        
        DestViewController.scheduleChoice = appoinmentList[indexPath.row]
        
        
        
        
    }

}
