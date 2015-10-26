

import UIKit

class ScheduleViewController: UITableViewController {
    
    var appoinmentList = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        appoinmentList = [("Athletic Center"),("Professors")]

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
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        let DestViewController = segue.destinationViewController as! AtheleticProfessorViewController
        
        DestViewController.scheduleChoice = appoinmentList[indexPath.row]
        
        
        
        
    }

}
