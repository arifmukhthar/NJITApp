
import UIKit

class AtheleticProfessorViewController: UITableViewController {
    var list = [String]()
    var scheduleChoice = String()
    var temp = String()
     var MyArray = [String()]
    override func viewDidLoad() {
        super.viewDidLoad()
        if scheduleChoice == "Athletic Center"
        {
                getJSON("https://web.njit.edu/~ts336/athletic.php")
        }else{
            getJSON("https://web.njit.edu/~rb454/departmentlist.php")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell1 = UITableViewCell()
        if scheduleChoice == "Athletic Center"
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
    
    func getJSON(url: String){
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        
        do{
            let JSONresult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            var i = 0
            
            for _ in JSONresult!{
                let dd = JSONresult![i]
                if scheduleChoice == "Athletic Center"{
                list.append(dd["games"] as! String)
                }else{
                    list.append(dd["Department"] as! String)
                }
                i = i+1
            }
            print(JSONresult)
            
        }catch let error as NSError{
            print(error)
        }
    }

    
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        if scheduleChoice == "Athletic Center"
        {
        let destViewController = segue.destinationViewController as! SetAppoinmentAtheleticViewController
            
            destViewController.scheduleChoice = scheduleChoice
            
            destViewController.optionChoosed = list[indexPath.row]
        }else{
            let destViewController = segue.destinationViewController as! ProfessorListViewController
            
            destViewController.scheduleChoice = scheduleChoice
            
            destViewController.optionChoosed = list[indexPath.row]

        }
       
        
    }
    
}
