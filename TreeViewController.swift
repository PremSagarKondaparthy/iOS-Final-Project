//
//  TreeViewController.swift
//  Tree_Reminder
//
//  Created by Michael Rogers on 11/28/16.
//  Copyright © 2016 Kotte,Manoj Kumar. All rights reserved.
//

import UIKit

//
//  SecondViewController.swift
//  Tree_Reminder
//
//  Created by Kotte,Manoj Kumar on 10/4/16.
//  Copyright © 2016 Kotte,Manoj Kumar. All rights reserved.
//
import CoreData
import UIKit

class TreeViewController: UITableViewController{
    let managedObjectContext : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    var trees:[Tree]! = []
    var dateFormatter:NSDateFormatter!
    
    var TREE_TAG = 100
    var DATE_TAG = 101
    var INTERVAL_TAG = 102
    
    @IBOutlet var gardenTBL:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "TableViewCell", bundle: nil),
                                   forCellReuseIdentifier: "trees")
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT +3:00")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do{
            
            let fr = NSFetchRequest(entityName: "Tree")
            trees = try managedObjectContext.executeFetchRequest(fr) as! [Tree]
            
        } catch{
            
        }
        //print(trees.count)
        return trees.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("trees", forIndexPath: indexPath)
        let tree = trees[indexPath.row]
        let nameLBL:UILabel = cell.contentView.viewWithTag(TREE_TAG) as! UILabel
        let dateLBL:UILabel = cell.contentView.viewWithTag(DATE_TAG) as! UILabel
        let waterIntervalLBL:UILabel = cell.contentView.viewWithTag(INTERVAL_TAG) as! UILabel
        nameLBL.text = tree.name!
        dateLBL.text = dateFormatter.stringFromDate(tree.date!)
        waterIntervalLBL.text = "\(tree.wateringinterval!) Days"
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        
        
    }
}

