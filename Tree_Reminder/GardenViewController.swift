//
//  FirstViewController.swift
//  Tree_Reminder
//
//  Created by Kotte,Manoj Kumar on 10/4/16.
//  Copyright © 2016 Kotte,Manoj Kumar. All rights reserved.
//

import CoreData

import UIKit

class GardenViewController: UIViewController {
    @IBOutlet weak var gardenView: UIView!
    
    let managedObjectContext : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as!
    AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            // This code is used to clear the data in the database
            
       //     let fetchRequestTree = NSFetchRequest(entityName: "Tree")
            
           //  Create Batch Delete Request
            
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequestTree)
            
//            do {
//                try managedObjectContext.executeRequest(batchDeleteRequest)
//                
//            } catch {
//                
//                // Error Handling
//                
//                print("Error when trying to deleting trees: \(error)")
//                
//            }
            
            let fr = NSFetchRequest(entityName: "Tree")
            
            let treees = try managedObjectContext.executeFetchRequest(fr) as! [Tree]
            // plant all the trees so they are visible
            for tree in treees{
                let frame = CGRectMake(100, 100, 44, 44)
                let plantView = PlantView(frame : frame, name:tree.name!)
                plantView.center = CGPoint(x:CGFloat(tree.x!), y:CGFloat(tree.y!))
                plantView.image = UIImage(named: tree.type!)
                plantView.contentMode = UIViewContentMode.ScaleAspectFit
                gardenView.addSubview(plantView)
            }
            
        }
        catch{
            
            }

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier != "help" {
            let sendingVC : EntryViewController = segue.destinationViewController as! EntryViewController
            //            sendingVC.plantIMG.image = UIImage(named:segue.identifier)
            sendingVC.imageName = segue.identifier
        }
        
    }
    
    @IBAction func unwindToTree(segue:UIStoryboardSegue){
        let sender = segue.sourceViewController as! EntryViewController
        let plantName = sender.plantNameTF.text!
        let frame = CGRectMake(100, 100, 44, 44)
        let plantView = PlantView(frame : frame, name: plantName)
        plantView.userInteractionEnabled = true
        plantView.image = UIImage(named: sender.imageName)
        plantView.contentMode = UIViewContentMode.ScaleAspectFit
        gardenView.addSubview(plantView)

    }
    
    @IBAction func Done(segue:UIStoryboardSegue){
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue){
    }
    
}
