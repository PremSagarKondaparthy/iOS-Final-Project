//
//  PlantView.swift
//  Tree_Reminder
//
//  Created by Kotte,Manoj Kumar on 10/16/16.
//  Copyright © 2016 Kotte,Manoj Kumar. All rights reserved.
//

import UIKit
import CoreData

class PlantView: UIImageView {
    
    let managedObjectContext : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    
    var name:String!
    
    init(frame: CGRect, name:String) {
        super.init(frame: frame)
        self.name = name
        let panGR:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        let tapGR:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.addGestureRecognizer(panGR)
        self.addGestureRecognizer(tapGR)
        userInteractionEnabled = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var startingPanLocation:CGPoint!
    
    
    func pan(panGR:UIPanGestureRecognizer)->Void {
        
        if panGR.state == .Began {
            startingPanLocation = self.frame.origin
        }
      
        
        let putativeNewFrame = CGRect(x:startingPanLocation.x + panGR.translationInView(self.superview).x, y:startingPanLocation.y + panGR.translationInView(self.superview).y, width:self.frame.size.width, height:self.frame.size.height)
        if self.superview!.bounds.contains(putativeNewFrame) {
            self.frame.origin.x = startingPanLocation.x + panGR.translationInView(self.superview).x
            self.frame.origin.y = startingPanLocation.y + panGR.translationInView(self.superview).y
        }
        
        if panGR.state == .Ended {
            do{
                let fr = NSFetchRequest(entityName: "Tree")
                fr.predicate = NSPredicate(format: "name contains %@",  self.name!)
                
                let treees = try managedObjectContext.executeFetchRequest(fr) as! [Tree]
                treees[0].x = self.center.x
                treees[0].y = self.center.y
                try managedObjectContext.save()
            }
            catch{
                print("Something has gone wrong with the fetch request: \(error)")
            }
        }
        
    }
    
    func tap(tapGR:UITapGestureRecognizer){
        
        // Working on this code
        
//        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("popViewController") as! PopUpViewController
//        self.addSubview(popVC.view)
//        popVC.treeName.text = name
//        let gardenVC = GardenViewController()
//        popVC.didMoveToParentViewController(gardenVC)
        
        print(name)
        
    }
    
}
