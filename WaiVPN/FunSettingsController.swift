//
//  FunSettingsController.swift
//  WaiVPN
//
//  Created by Jaden on 16/09/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

import UIKit



class FunSettingsController: UITableViewController {
    
    let fromMainController = ViewController.self
    
    @IBOutlet weak var modeCells: UITableView!
    
    // Declare main variables so I dont have to write them down again.
    let jordanSwitch  = UISwitch(frame: .zero)
    let ethanSwitch   = UISwitch(frame: .zero)
    let rileeSwitch   = UISwitch(frame: .zero)
    let jacobSwitch   = UISwitch(frame: .zero)
    let kodeeSwitch   = UISwitch(frame: .zero)
    let verboseSwitch = UISwitch(frame: .zero)
    
    
    
    func SaveAll() {
        UserDefaults.standard.setValue(verboseSwitch.isOn,  forKeyPath: "verboseStateFun")
        UserDefaults.standard.setValue(jordanSwitch.isOn,   forKeyPath: "jordanStateFun")
        UserDefaults.standard.setValue(ethanSwitch.isOn,    forKeyPath: "ethanStateFun")
        UserDefaults.standard.setValue(rileeSwitch.isOn,    forKeyPath: "rileeStateFun")
        UserDefaults.standard.setValue(jacobSwitch.isOn,    forKeyPath: "jacobStateFun")
        UserDefaults.standard.setValue(kodeeSwitch.isOn,    forKeyPath: "kodeeStateFun")
        print("saved all")
    }
    // MARK: - Table view data source
    
    // Return 1 table view section
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // Return 3 table view rows in the section.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    // Display footer text under the table view section.
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return "Fun settings do not affect performance in any way."
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.00
    }
    
    // At each case, it will display the cell specified. (Jordan Mode, Ethan Mode, Verbose Mode)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let imagesCell = tableView.dequeueReusableCell(withIdentifier: "imagesCell", for: indexPath)
            return imagesCell
            
        case 1:
            let ethanCell = tableView.dequeueReusableCell(withIdentifier: "ethanMode", for: indexPath)

            ethanSwitch.tag = indexPath.row
            
            ethanSwitch.addTarget(self, action: #selector(self.ethanSwitchChanged(_:)), for: .valueChanged)
            
            ethanCell.accessoryView = ethanSwitch
            
            
            return ethanCell
        case 2:
            
            let rileeCell = tableView.dequeueReusableCell(withIdentifier: "rileeMode", for: indexPath)
            
            rileeSwitch.tag = indexPath.row
            
            rileeSwitch.addTarget(self, action: #selector(self.rileeSwitchChanged(_:)), for: .valueChanged)
            
            rileeCell.accessoryView = rileeSwitch
            
            
            
            return rileeCell
            
        case 3:
            let jacobCell = tableView.dequeueReusableCell(withIdentifier: "jacobMode", for: indexPath)
            
            jacobSwitch.tag = indexPath.row
            
            jacobSwitch.addTarget(self, action: #selector(self.jacobSwitchChanged(_:)),for: .valueChanged)
            
            jacobCell.accessoryView = jacobSwitch
            
            return jacobCell
            
        case 4:
            let kodeeCell = tableView.dequeueReusableCell(withIdentifier: "kodeeMode", for: indexPath)
            
            kodeeSwitch.tag = indexPath.row
            
            kodeeSwitch.addTarget(self, action: #selector(self.kodeeSwitchChanged(_:)), for: .valueChanged)
            kodeeCell.accessoryView = kodeeSwitch
            
            return kodeeCell
            
        case 5:
            
            let audioCell = tableView.dequeueReusableCell(withIdentifier: "audioCell", for: indexPath)
            return audioCell
            
            
            
        case 6:
            
            let jordanCell = tableView.dequeueReusableCell(withIdentifier: "jordanMode", for: indexPath)
            
            jordanSwitch.tag = indexPath.row
            
            // Specifies which function will be working with this switch., which is the 'jordanSwitchChanged' function.
            jordanSwitch.addTarget(self, action: #selector(self.jordanSwitchChanged(_:)), for: .valueChanged)
            
            jordanCell.accessoryView = jordanSwitch
            
            // return the cell inside the table view.
            return jordanCell
            
            
            
        case 7:
            
            let otherCell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath)
            return otherCell
            
            
        case 8:
            let verboseCell = tableView.dequeueReusableCell(withIdentifier: "verboseMode", for: indexPath)
            
            verboseSwitch.tag = indexPath.row
            
            // Specifies which function will be working with this switch., which is the 'jordanSwitchChanged' function.
            verboseSwitch.addTarget(self, action: #selector(self.verboseSwitchChanged(_:)), for: .valueChanged)
            
            verboseCell.accessoryView = verboseSwitch
            
            // return the cell inside the table view.
            return verboseCell
            
        // If none of the above cant be displayed for some reason, just return UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    
    // Print if the switch actually worked.
    @objc func jordanSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(jordanSwitch.isOn, forKeyPath: "jordanStateFun")
        
        if UserDefaults.standard.bool(forKey: "jordanStateFun") == true {
            print("jordan mode is ON")
        }
        else {
            print("jordan mode is OFF")
        }
        SaveAll()
        UserDefaults.standard.synchronize()
    }
    @objc func ethanSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(ethanSwitch.isOn, forKeyPath: "ethanStateFun")
        
        
        if UserDefaults.standard.bool(forKey: "ethanStateFun") == true {
            
            print("ethan mode is ON")
        }
        else {
            print("ethan mode is OFF")
        }
        if UserDefaults.standard.bool(forKey: "rileeStateFun") == true {
            rileeSwitch.isOn = false
        }
        if UserDefaults.standard.bool(forKey: "jacobStateFun") == true {
            jacobSwitch.isOn = false
        }
        if UserDefaults.standard.bool(forKey: "kodeeStateFun") == true {
            kodeeSwitch.isOn = false
        }
        
        SaveAll()
        UserDefaults.standard.synchronize()
    }
    @objc func rileeSwitchChanged(_ sender: UISwitch!) {
        
        UserDefaults.standard.setValue(rileeSwitch.isOn, forKeyPath: "rileeStateFun")
        if UserDefaults.standard.bool(forKey: "rileeStateFun") == true {
            print("rilee mode is ON")
        }
        else {
            print("rilee mode is OFF")
        }
        if UserDefaults.standard.bool(forKey: "ethanStateFun") == true {
            ethanSwitch.isOn = false
        }
        if UserDefaults.standard.bool(forKey: "jacobStateFun") == true {
            jacobSwitch.isOn = false
        }
        if UserDefaults.standard.bool(forKey: "kodeeStateFun") == true {
            kodeeSwitch.isOn = false
        }
        
        SaveAll()
        UserDefaults.standard.synchronize()
        
    }
    @objc func jacobSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(jacobSwitch.isOn, forKeyPath: "jacobStateFun")
         if UserDefaults.standard.bool(forKey: "jacobStateFun") == true {
             print("jacob mode is ON")
         }
         else {
             print("jacob mode is OFF")
         }
         if UserDefaults.standard.bool(forKey: "ethanStateFun") == true {
             ethanSwitch.isOn = false
         }
         if UserDefaults.standard.bool(forKey: "rileeStateFun") == true {
            rileeSwitch.isOn = false
        }
        if UserDefaults.standard.bool(forKey: "kodeeStateFun") == true {
            kodeeSwitch.isOn = false
        }
        
         
         SaveAll()
         UserDefaults.standard.synchronize()
    }
    @objc func kodeeSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(kodeeSwitch.isOn, forKeyPath: "kodeeStateFun")
        if UserDefaults.standard.bool(forKey: "kodeeStateFun") == true {
            print("kodee mode is ON")
        }
        else {
            print("kodee mode is OFF")
        }
        if UserDefaults.standard.bool(forKey: "ethanStateFun") == true {
             ethanSwitch.isOn = false
         }
        if UserDefaults.standard.bool(forKey: "rileeStateFun") == true {
            rileeSwitch.isOn = false
        }
        if UserDefaults.standard.bool(forKey: "jacobStateFun") == true {
            jacobSwitch.isOn = false
        }
        SaveAll()
        
    }
    @objc func verboseSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(verboseSwitch.isOn, forKeyPath: "verboseStateFun")
        if UserDefaults.standard.bool(forKey: "verboseStateFun") == true {
            
            print("verbose mode is ON")
        }
        else {
            print("verbose mode is OFF")
        }
        SaveAll()
        UserDefaults.standard.synchronize()
    }
    
    
   
    // When this view controller loads, do these.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jordanSwitch.onTintColor  = fromMainController.colors.trackColor
        verboseSwitch.onTintColor = fromMainController.colors.trackColor
        ethanSwitch.onTintColor   = fromMainController.colors.trackColor
        rileeSwitch.onTintColor   = fromMainController.colors.trackColor
        jacobSwitch.onTintColor   = fromMainController.colors.trackColor
        kodeeSwitch.onTintColor   = fromMainController.colors.trackColor
        
        jordanSwitch.isOn         = UserDefaults.standard.bool(forKey: "jordanStateFun")
        ethanSwitch.isOn          = UserDefaults.standard.bool(forKey: "ethanStateFun")
        verboseSwitch.isOn        = UserDefaults.standard.bool(forKey: "verboseStateFun")
        rileeSwitch.isOn          = UserDefaults.standard.bool(forKey: "rileeStateFun")
        jacobSwitch.isOn          = UserDefaults.standard.bool(forKey: "jacobStateFun")
        kodeeSwitch.isOn          = UserDefaults.standard.bool(forKey: "kodeeStateFun")
        
        
        // Decleare the datasource and delegate as self (FunSettingsController class)
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        
        
    }
    
    
}
