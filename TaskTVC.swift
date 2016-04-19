//
//  TaskTVC.swift
//  ToDoList
//
//  Created by Nayeem on 12/8/15.
//  Copyright © 2015 Mohammed Khan. All rights reserved.
//

import UIKit

import CoreData

class TaskTVC: UITableViewController {

    let moreContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }

    
    
    override func viewDidAppear(animated: Bool) {
        var error:NSError?
        
        
        let request = NSFetchRequest(entityName: "Task")
        
        tasks  = (try! moreContext.executeFetchRequest(request)) as! [Task]
        
        self.tableView.reloadData()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.tName
        cell.detailTextLabel?.text = task.tDesc
        //print(task.tImage)
        //print(cell.imageView)
        if task.tImage != nil {
            cell.imageView?.image = UIImage(data: task.tImage!)
        }
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "editTask"
        {
            let v = segue.destinationViewController as! ViewController
            
            let indexpath = self.tableView.indexPathForSelectedRow
            let row = indexpath?.row
            
            v.task = tasks[row!]
        }
    
    
    }
    
    
    
    /******************************************************************************
     *
     * This function Display Action Controller to get the store name
     *
     ******************************************************************************/
    
    
    @IBAction func searchRecords(sender: AnyObject) {
        
        // create the alert controller
        
        let v = UIAlertController(title: "Search", message: "Enter task name", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        // Add the text field
        
        v.addTextFieldWithConfigurationHandler { (taskName:UITextField!) -> Void in
            
            taskName.placeholder = "Task Name"
            
        }
        
        
        // Create the button - Alert Action
        
        let okAc = UIAlertAction(title: "Search", style: UIAlertActionStyle.Default)
            { (alert: UIAlertAction) in
                
                let taskName = v.textFields![0]
                
                self.filterStores(taskName.text!)
                
                v.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        // Add it to the controller
        
        v.addAction(okAc)
        
        
        // only one cancel action style allowed
        
        let cancelAc = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel) { (alert: UIAlertAction) in
            
            v.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        v.addAction(cancelAc)
        
        presentViewController(v, animated: true , completion: nil)
        
    }
    
    
    /*****************************************************************************
     *
     * This function search core data
     *
     ******************************************************************************/
    
    func filterStores(searchText: String)
    {
        
        var error:NSError?
        
        let request = NSFetchRequest(entityName: "Task")
        
        let predicate = NSPredicate(format: "tName  contains %@", searchText)
        
        request.predicate = predicate
        
        tasks  = (try! moreContext.executeFetchRequest(request)) as! [Task]
        
        self.tableView.reloadData()
        
        
    }



}
