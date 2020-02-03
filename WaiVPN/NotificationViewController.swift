//
//  notificationViewController.swift
//  WaiVPN
//
//  Created by Jaden Stewart on 26/11/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var continueProps2: UIButton!
    @IBOutlet weak var continueProps: UIButton!
    @IBOutlet weak var middleText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    
    
    
    @IBAction func connectionButton(_ sender: Any) {
        
        let notiStoryboard = UIStoryboard(name: "Access", bundle: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "mainVC") as! UINavigationController
        
        func displayConfirmation() {
           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
                 guard granted
                     
                 else {
                     return
                 }
            
                 DispatchQueue.main.async {
             
                 UIApplication.shared.registerForRemoteNotifications()
             
                 }
             }
        }
        displayConfirmation()
        UserDefaults.standard.set(true, forKey: "hasLaunched")
        self.present(mainVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueProps?.layer.cornerRadius = 15
        continueProps2?.layer.cornerRadius = 15
    }
}
