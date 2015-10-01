
import UIKit

class AtheleticViewController: UITableViewController {
    var list = [String]()
    var scheduleChoice = String()
    var temp = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell1 = UITableViewCell()
        if scheduleChoice == "Atheletic Center"
        {
        var Cell = self.tableView.dequeueReusableCellWithIdentifier("AtheleticCell", forIndexPath: indexPath) as UITableViewCell
        Cell.textLabel?.text = list[indexPath.row]
        cell1 = Cell
        }
        else{
            var Cell2 = self.tableView.dequeueReusableCellWithIdentifier("ProfessorCell", forIndexPath: indexPath) as UITableViewCell
            Cell2.textLabel?.text = list[indexPath.row]
            cell1 = Cell2
        }
        return cell1
    }
    
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        var indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        
        if scheduleChoice == "Atheletic Center"
        {
        
            var destViewController = segue.destinationViewController as! SetAppoinmentAtheleticViewController
        
            destViewController.scheduleChoice = scheduleChoice
        
            destViewController.optionChoosed = list[indexPath.row]
        }
        else{
        
            var destViewController = segue.destinationViewController as! SetAppoinmentProfessorViewController
            
        }
        
    }
  
    
  
 

}
