//
//  ProtocolController.swift
//  WaiVPN
//
//  Created by Jaden on 14/09/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

import UIKit

class ProtocolController: UITableViewController {
    
    
    @IBOutlet weak var protocolCells: UITableView!
    
    // structure that defines the protocol switches
    struct globalSwitches {
        static let tcpSwitch = UISwitch(frame: .zero)
        static let udpSwitch = UISwitch(frame: .zero)
    }
    
    
    // function to save all userdefaults to save me writing more code
    func SaveAll() {
        UserDefaults.standard.setValue(globalSwitches.udpSwitch.isOn, forKeyPath: "udpState")
        UserDefaults.standard.setValue(globalSwitches.tcpSwitch.isOn, forKeyPath: "tcpState")
        
        print("saved all")
    }
    
    // returns only 1 section
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    // returns 2 rows (cells) in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    // footer under the section that displays the below string.
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return "UDP is set to default and is recommended over TCP."
    }
    
    // changes the height of each cell to 70px
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // on each cell that should be displayed (2), create a title for each one and add the switch
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            
           // this constant below makes a cell (row) with the indentifier "udp". I can then use the identifier to make changes to that specific cell in future
            let udpCell = tableView.dequeueReusableCell(withIdentifier: "udp", for: indexPath)
            
            // sets a target which is udpSwitchChanged, this means it will run the code from the udpswitchedchanged fucntion when the switch is changed on this cell
            globalSwitches.udpSwitch.tag = indexPath.row
            globalSwitches.udpSwitch.addTarget(self, action: #selector(self.udpSwitchChanged(_:)), for: .valueChanged)
            
            // set the accessoryview to the switch that was defined in the struct
            udpCell.accessoryView = globalSwitches.udpSwitch
            
            
            return udpCell
            
        case 1:
            
            //this constant below makes a cell (row) with the indentifier "tcp". I can then use the identifier to make changes to that specific cell in future
            let tcpCell = tableView.dequeueReusableCell(withIdentifier: "tcp", for: indexPath)
            
            // sets a target which is udpSwitchChanged, this means it will run the code from the udpswitchedchanged fucntion when the switch is changed on this cell
            globalSwitches.tcpSwitch.tag = indexPath.row
            globalSwitches.tcpSwitch.addTarget(self, action: #selector(self.tcpSwitchChanged(_:)), for: .valueChanged)
            
            // set the accessoryview to the switch that was defined in the struct
            tcpCell.accessoryView = globalSwitches.tcpSwitch
            
            
            return tcpCell
            
            
        default:
            
            return UITableViewCell()
        }
        
        
    }
    
    //function that operates the code when UDP switch is changed
    @objc func udpSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(globalSwitches.udpSwitch.isOn, forKeyPath: "udpState")

        // when UDP is switched to true, make TCP switch false
        if UserDefaults.standard.bool(forKey: "udpState") == true {
            print("udp ON")
            globalSwitches.tcpSwitch.isOn = false
        }
            
        // when TCP is switched to true, make UDP switch false
        else {
            print("udp OFF")
            globalSwitches.tcpSwitch.isOn = true
        }
        
        // save all the userdefaults
        SaveAll()
        
        // this is useless but oh well
        UserDefaults.standard.synchronize()
    }
    
    // function that operates the code when TCP switch is changed.
    @objc func tcpSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(globalSwitches.tcpSwitch.isOn, forKeyPath: "tcpState")
        
        if UserDefaults.standard.bool(forKey: "tcpState") == true {
            print("tcp ON")
            globalSwitches.udpSwitch.isOn = false
        }
        else {
            print("tcp OFF")
            globalSwitches.udpSwitch.isOn = true
        }
        
        SaveAll()
        UserDefaults.standard.synchronize()
    }

    // When view controller loads for the first time, run this code
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change the color of the TCP and UDP switches in the table view cell accessory
        globalSwitches.udpSwitch.onTintColor = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
        globalSwitches.tcpSwitch.onTintColor = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
        
        // not sure if this even works
        if UserDefaults.standard.bool(forKey: "udpState") && UserDefaults.standard.bool(forKey: "tcpState") == false {
            globalSwitches.udpSwitch.isOn = true
            
            SaveAll()
        }
        
        // hard to explain but if userdefaults was set to true on TCP then load TCP true when view controller loads. This means UDP has to be false
        globalSwitches.tcpSwitch.isOn = UserDefaults.standard.bool(forKey: "tcpState")
        globalSwitches.udpSwitch.isOn = UserDefaults.standard.bool(forKey: "udpState")

        self.tableView.dataSource = self
        self.tableView.delegate   = self
        view = tableView
    }



}
