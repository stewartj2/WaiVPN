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

    
     
    
    @IBOutlet weak var timerSwitch: UISwitch!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        let timeFormatter = DateFormatter()
           
        timeFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = timeFormatter.string(from: timerPicker.date)
        
        UserDefaults.standard.set(strDate, forKey: "kDatePicker")
        let alert = UIAlertController(title: "Saved time", message: "Successfully saved your time: \(strDate)", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default)
       alert.addAction(okAlert)
       present(alert, animated: true, completion: nil)
    }
    
        
    
    @IBAction func userPickedTime(_ sender: UIDatePicker) {
        
    }
    @IBAction func timerSwitchState(_ sender: UISwitch) {
        
        UserDefaults.standard.set(timerSwitch.isOn, forKey: "timerSwitchState")
        if UserDefaults.standard.bool(forKey: "timerSwitchState") == true {
            print("new time is now", timerPicker.date)
            timerPicker.isEnabled = true
            saveButton.isEnabled  = true
            
            saveButton.setTitleColor(UIColor.white, for: .normal)
            
            
        }
        else {
            saveButton.isEnabled  = false
            timerPicker.isEnabled = false
            
            saveButton.setTitleColor(UIColor.gray, for: .normal)
            print("timer switch is false")
        }
    }


    // When view controller loads, do these.
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "timerSwitchState") == false {
            let alert = UIAlertController(title: "Disclaimer", message: "The time shown in the date picker will not save when returning back to this page. I am working on a fix.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Caring.", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
        
        
        timerSwitch.isOn = UserDefaults.standard.bool(forKey: "timerSwitchState")
        
        let date = NSDate()

        let tz = NSTimeZone.local
        if tz.isDaylightSavingTime(for: date as Date) {
            print("DAYLIGHT TRUE")
        }
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
