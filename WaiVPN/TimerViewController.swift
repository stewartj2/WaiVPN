//
//  TimerViewController.swift
//  WaiVPN
//
//  Created by Jaden on 24/08/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

import UIKit
import UserNotifications

class TimerViewController: UIViewController {

    
     
    // outlets being used in the IB
    @IBOutlet weak var timerSwitch: UISwitch!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    // save button to save timer values
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        let timeFormatter = DateFormatter()
           
        // set style of date to "00:00 PM" (short)
        timeFormatter.timeStyle = DateFormatter.Style.short
        
        // get the string value from date picker
        let strDate = timeFormatter.string(from: timerPicker.date)
        
        //save string of strDate variable
        UserDefaults.standard.set(strDate, forKey: "kDatePicker")
        
        // display alert that says that time was successfully saved.
        let alert = UIAlertController(title: "Saved time", message: "Successfully saved your time: \(strDate)", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default)
        
        // add an ok button to the alert controller
       alert.addAction(okAlert)
        
        // present the alert to the screen
       present(alert, animated: true, completion: nil)
    }
    
        
    // dont mind this.
    @IBAction func userPickedTime(_ sender: UIDatePicker) {
        
    }
    
    // when timer switch gets changed
    @IBAction func timerSwitchState(_ sender: UISwitch) {
        
       
        UserDefaults.standard.set(timerSwitch.isOn, forKey: "timerSwitchState")
        
        // unlock buttons
        if UserDefaults.standard.bool(forKey: "timerSwitchState") == true {
            print("new time is now", timerPicker.date)
            timerPicker.isEnabled = true
            saveButton.isEnabled  = true
            
            // changes text to white
            saveButton.setTitleColor(UIColor.white, for: .normal)
            
            
        }
            
        // lock buttons
        else {
            saveButton.isEnabled  = false
            timerPicker.isEnabled = false
            
            // changes text to grey
            saveButton.setTitleColor(UIColor.gray, for: .normal)
            
            print("timer switch is false")
        }
    }


    // When view controller loads, do these.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // when opening timer view controller while switch is off, display a message saying that i am fixing a bug.
        if UserDefaults.standard.bool(forKey: "timerSwitchState") == false {
            
            let alert = UIAlertController(title: "Disclaimer", message: "The time shown in the date picker will not save when returning back to this page. I am working on a fix.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Caring.", style: .default)
            
            // add ok button to alert controller
            alert.addAction(ok)
            
            // present alert to the screen
            present(alert, animated: true)
        }
        
        
        timerSwitch.isOn = UserDefaults.standard.bool(forKey: "timerSwitchState")
        
        let date = NSDate()
        
        // get current date / time
        let tz = NSTimeZone.local
        
        // check for daylight savings
        if tz.isDaylightSavingTime(for: date as Date) {
            print("DAYLIGHT TRUE")
        }
        
        // change button corner to become rounded instead of square
        saveButton.layer.cornerRadius = 15

        timerSwitch.isOn = UserDefaults.standard.bool(forKey: "timerSwitchState")
        
        if UserDefaults.standard.bool(forKey: "timerSwitchState") == false {
            timerPicker.isEnabled = false
            
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor.gray, for: .disabled)
        }
        else {
            timerPicker.isEnabled = true
            saveButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        // Set the color of the time picker to white, otherwise it will be set to black by default and will not match the dark blue background.
        timerPicker.setValue(UIColor.white, forKeyPath: "textColor")
        
    }
    
    

}
