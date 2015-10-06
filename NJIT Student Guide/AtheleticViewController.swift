
import UIKit

class AtheleticViewController: UITableViewController {
    var list = [String]()
    var scheduleChoice = String()
    var temp = String()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell1 = UITableViewCell()
        if scheduleChoice == "Atheletic Center"
        {
        let Cell = self.tableView.dequeueReusableCellWithIdentifier("AtheleticCell", forIndexPath: indexPath) as UITableViewCell
        Cell.textLabel?.text = list[indexPath.row]
        cell1 = Cell
        }
        else{
            let Cell2 = self.tableView.dequeueReusableCellWithIdentifier("ProfessorCell", forIndexPath: indexPath) as UITableViewCell
            Cell2.textLabel?.text = list[indexPath.row]
            cell1 = Cell2
        }
        return cell1
    }
    
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        let destViewController = segue.destinationViewController as! SetAppoinmentAtheleticViewController
        
        destViewController.scheduleChoice = scheduleChoice
        
        destViewController.optionChoosed = list[indexPath.row]
        
        /*if scheduleChoice == d"Atheletic Center"
        {
        
            let destViewController = segue.destinationViewController as! SetAppoinmentAtheleticViewController
        
            destViewController.scheduleChoice = scheduleChoice
        
            destViewController.optionChoosed = list[indexPath.row]
        }
        else{
        
            let destViewController = segue.destinationViewController as! SetAppoinmentAtheleticViewController
            
            destViewController.scheduleChoice = scheduleChoice
            
            destViewController.optionChoosed = list[indexPath.row]
            
        }*/
        
    }
    
}
