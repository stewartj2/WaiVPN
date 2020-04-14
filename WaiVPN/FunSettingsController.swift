//
//  FunSettingsController.swift
//  WaiVPN
//
//  Created by Jaden on 16/09/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

import UIKit



class FunSettingsController: UITableViewController {
    
    // ViewController is the class name for the main page, this will allow me to use the struct i made to get information from there to this controller
    let fromMainController = ViewController.self
    
    @IBOutlet weak var modeCells: UITableView!
    
    // Declare switch constants so I dont have to write them down again.
    let jordanSwitch  = UISwitch(frame: .zero)
    let ethanSwitch   = UISwitch(frame: .zero)
    let rileeSwitch   = UISwitch(frame: .zero)
    let jacobSwitch   = UISwitch(frame: .zero)
    let kodeeSwitch   = UISwitch(frame: .zero)
    let verboseSwitch = UISwitch(frame: .zero)
    
    
    // saves all userdefault settings so i can save writing more code
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
    
    // Sets the tableview cells to 55px
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
            
            // sets a target which is ethanSwitchChanged, this means it will run the code from the ethanSwitchChanged function when the switch is changed on this cell
            ethanSwitch.addTarget(self, action: #selector(self.ethanSwitchChanged(_:)), for: .valueChanged)
            
            ethanCell.accessoryView = ethanSwitch
            
            
            return ethanCell
        case 2:
            
            let rileeCell = tableView.dequeueReusableCell(withIdentifier: "rileeMode", for: indexPath)
            
            rileeSwitch.tag = indexPath.row
            
            // sets a target which is rileeSwitchChanged, this means it will run the code from the rileeSwitchChanged function when the switch is changed on this cell
            rileeSwitch.addTarget(self, action: #selector(self.rileeSwitchChanged(_:)), for: .valueChanged)
            
            rileeCell.accessoryView = rileeSwitch
            
            
            
            return rileeCell
            
        case 3:
            let jacobCell = tableView.dequeueReusableCell(withIdentifier: "jacobMode", for: indexPath)
            
            jacobSwitch.tag = indexPath.row
            
            // sets a target which is jacobSwitchChanged, this means it will run the code from the jacobSwitchChanged function when the switch is changed on this cell
            jacobSwitch.addTarget(self, action: #selector(self.jacobSwitchChanged(_:)),for: .valueChanged)
            
            jacobCell.accessoryView = jacobSwitch
            
            return jacobCell
            
        case 4:
            let kodeeCell = tableView.dequeueReusableCell(withIdentifier: "kodeeMode", for: indexPath)
            
            kodeeSwitch.tag = indexPath.row
            
            // sets a target which is kodeeSwitchChanged, this means it will run the code from the kodeeSwitchChanged function when the switch is changed on this cell
            kodeeSwitch.addTarget(self, action: #selector(self.kodeeSwitchChanged(_:)), for: .valueChanged)
            kodeeCell.accessoryView = kodeeSwitch
            
            return kodeeCell
            
        case 5:
            
            let audioCell = tableView.dequeueReusableCell(withIdentifier: "audioCell", for: indexPath)
            return audioCell
            
            
            
        case 6:
            
            let jordanCell = tableView.dequeueReusableCell(withIdentifier: "jordanMode", for: indexPath)
            
            jordanSwitch.tag = indexPath.row
            
            // sets a target which is jordanSwitchChanged, this means it will run the code from the jordanSwitchChanged function when the switch is changed on this cell
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
            
            // sets a target which is verboseSwitchChanged, this means it will run the code from the verboseSwitchChanged function when the switch is changed on this cell
            verboseSwitch.addTarget(self, action: #selector(self.verboseSwitchChanged(_:)), for: .valueChanged)
            
            verboseCell.accessoryView = verboseSwitch
            
            // return the cell inside the table view.
            return verboseCell
            
        // If none of the above cant be displayed for some reason, just return a table view cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
    // function that operates the code when jordan switch is changed.
    @objc func jordanSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(jordanSwitch.isOn, forKeyPath: "jordanStateFun")
        
        // if switch true then print on, if its false then print off
        if UserDefaults.standard.bool(forKey: "jordanStateFun") == true {
            print("jordan mode is ON")
        }
        else {
            print("jordan mode is OFF")
        }
        SaveAll()
        UserDefaults.standard.synchronize()
    }
    // function that operates the code when ethan switch is changed.
    @objc func ethanSwitchChanged(_ sender: UISwitch!) {
        
        // creates a value for when ethanSwitch is set to true or false on the switch
        UserDefaults.standard.setValue(ethanSwitch.isOn, forKeyPath: "ethanStateFun")
        
        // if switch true then print on, if its false then print off
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
    // function that operates the code when rilee switch is changed.
    @objc func rileeSwitchChanged(_ sender: UISwitch!) {
        // creates a value for when rileeSwitch is set to true or false on the switch
        UserDefaults.standard.setValue(rileeSwitch.isOn, forKeyPath: "rileeStateFun")
        
        // if switch true then print on, if its false then print off
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
    // function that operates the code when jacob switch is changed.
    @objc func jacobSwitchChanged(_ sender: UISwitch!) {
        
        // creates a value for when jacobSwitch is set to true or false on the switch
        UserDefaults.standard.setValue(jacobSwitch.isOn, forKeyPath: "jacobStateFun")
        
        // if switch true then print on, if its false then print off
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
    // function that operates the code when kodee switch is changed.
    @objc func kodeeSwitchChanged(_ sender: UISwitch!) {
        
        // creates a value for when kodeeSwitch is set to true or false on the switch
        UserDefaults.standard.setValue(kodeeSwitch.isOn, forKeyPath: "kodeeStateFun")
        
        // if switch true then print on, if its false then print off
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
    // function that operates the code when verbose switch is changed.
    @objc func verboseSwitchChanged(_ sender: UISwitch!) {
        
        // creates a value for when verboseSwitch is set to true or false on the switch
        UserDefaults.standard.setValue(verboseSwitch.isOn, forKeyPath: "verboseStateFun")
        
        // if switch true then print on, if its false then print off
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
        
        // gets information from the struct in ViewController and sets the onTintColor on the switches
        jordanSwitch.onTintColor  = fromMainController.colors.trackColor
        verboseSwitch.onTintColor = fromMainController.colors.trackColor
        ethanSwitch.onTintColor   = fromMainController.colors.trackColor
        rileeSwitch.onTintColor   = fromMainController.colors.trackColor
        jacobSwitch.onTintColor   = fromMainController.colors.trackColor
        kodeeSwitch.onTintColor   = fromMainController.colors.trackColor
        
        // if userdefaults was set to true on each switch then load true when view controller loads
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
