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
    
    struct globalSwitches {
        static let tcpSwitch = UISwitch(frame: .zero)
        static let udpSwitch = UISwitch(frame: .zero)
    }
    
    

    func SaveAll() {
        UserDefaults.standard.setValue(globalSwitches.udpSwitch.isOn, forKeyPath: "udpState")
        UserDefaults.standard.setValue(globalSwitches.tcpSwitch.isOn, forKeyPath: "tcpState")
        
        print("saved all")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return "UDP is set to default and is recommended over TCP."
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let udpCell = tableView.dequeueReusableCell(withIdentifier: "udp", for: indexPath)

            globalSwitches.udpSwitch.tag = indexPath.row
            globalSwitches.udpSwitch.addTarget(self, action: #selector(self.udpSwitchChanged(_:)), for: .valueChanged)
            udpCell.accessoryView = globalSwitches.udpSwitch
            
            
            return udpCell
            
        case 1:
            let tcpCell = tableView.dequeueReusableCell(withIdentifier: "tcp", for: indexPath)
            
            
            globalSwitches.tcpSwitch.tag = indexPath.row
            globalSwitches.tcpSwitch.addTarget(self, action: #selector(self.tcpSwitchChanged(_:)), for: .valueChanged)
            tcpCell.accessoryView = globalSwitches.tcpSwitch
            
            
            return tcpCell
        default:
            
            return UITableViewCell()
        }
        
        
        
        
    }
    @objc func udpSwitchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.setValue(globalSwitches.udpSwitch.isOn, forKeyPath: "udpState")

        
        if UserDefaults.standard.bool(forKey: "udpState") == true {
            print("udp ON")
            globalSwitches.tcpSwitch.isOn = false
        }
        else {
            print("udp OFF")
            globalSwitches.tcpSwitch.isOn = true
        }
        SaveAll()
        UserDefaults.standard.synchronize()
    }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        globalSwitches.udpSwitch.onTintColor = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
        globalSwitches.tcpSwitch.onTintColor = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
        
        if UserDefaults.standard.bool(forKey: "udpState") && UserDefaults.standard.bool(forKey: "tcpState") == false {
            globalSwitches.udpSwitch.isOn = true
            
            SaveAll()
        }
        
        globalSwitches.tcpSwitch.isOn = UserDefaults.standard.bool(forKey: "tcpState")
        globalSwitches.udpSwitch.isOn = UserDefaults.standard.bool(forKey: "udpState")

        self.tableView.dataSource = self
        self.tableView.delegate   = self
        view = tableView
    }



}
