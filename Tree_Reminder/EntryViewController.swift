//
//  EntryViewController.swift
//  Tree_Reminder
//
//  Created by Prem sagar Kondaparthy on 10/6/16.
//  Copyright © 2016 Kotte,Manoj Kumar. All rights reserved.
//

import UIKit
import CoreData


// creation of a new tree
class EntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var allFieldsPresent:Bool!
    var dayArray:[Int] = []
    var dateFormatter:NSDateFormatter!
    
    
    @IBOutlet weak var plantIMG: UIImageView!
    @IBOutlet weak var plantNameTF: UITextField!
    @IBOutlet weak var intervalPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
  
    
    
    var imageName:String!
    
    @IBAction func SubmitButton(sender: UIButton) {
        
        allFieldsPresent = true // assume all fields are present
        
        if plantNameTF?.text?.characters.count > 0  {
            let tree = NSEntityDescription.insertNewObjectForEntityForName("Tree", inManagedObjectContext: managedObjectContext) as! Tree
            tree.name = plantNameTF?.text
            tree.date = datePicker.date
            tree.wateringinterval = dayArray[intervalPicker.selectedRowInComponent(0)]
            tree.type = imageName
            tree.x = 100
            tree.y = 100
            do{
                try managedObjectContext.save()
                performSegueWithIdentifier("unwindToTree", sender: nil)
            } catch{
                
            }
        }else{
            displayMessage("Enter all fields")
            allFieldsPresent = false
        }
        
        // This code is used to check the local notication for the specific time interval
        //NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(24*3600*dayArray[intervalPicker.selectedRowInComponent(0)]), target: self, selector: #selector(notiTrig(_:)), userInfo: nil, repeats: true)
       
        // This code is used to check the local notification for specific time in seconds
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(dayArray[intervalPicker.selectedRowInComponent(0)]), target: self, selector: #selector(notiTrig(_:)), userInfo: nil, repeats: true)
    }
    
    func notiTrig(timer:NSTimer){
        let fireDate:NSDate = datePicker.date
        let notification:UILocalNotification = UILocalNotification()
        notification.alertTitle = "Tree Reminder"
        notification.alertBody = "Hey! It's time to water \(plantNameTF.text)"
        notification.fireDate = fireDate
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.plantNameTF.delegate = self
        
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT +3:00")
        for i in 0...29 { dayArray.append(i)}
      
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        plantIMG.image = UIImage(named: imageName)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String,sender: AnyObject?) -> Bool {
        return identifier == "unwindToTree" && allFieldsPresent || identifier == "cancel"
    }

    
    
    func displayMessage(message:String) {
        let alert = UIAlertController(title: "", message: message,
                                      preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert,animated:true, completion:nil)
    }
    @IBAction func backToEntry(segue:UIStoryboardSegue) {
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dayArray.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: "\(dayArray[row])")
    }
    
    
}
