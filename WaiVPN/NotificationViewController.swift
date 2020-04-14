//
//  notificationViewController.swift
//  WaiVPN
//
//  Created by Jaden Stewart on 26/11/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

// frameworks
import Foundation
import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var continueProps2: UIButton!
    @IBOutlet weak var continueProps: UIButton!
    @IBOutlet weak var middleText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    
    
    // button
    @IBAction func connectionButton(_ sender: Any) {
        
        // create storyboards
        let notiStoryboard = UIStoryboard(name: "Access", bundle: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // instantiates the main view controller (which is the main page of the app with the connect button), instantiates meaning to get this view controller into memory so it can be loaded in the future.
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
        
        // sets a userdefaults to define if the user has launched and completed this view controller
        UserDefaults.standard.set(true, forKey: "hasLaunched")
        
        // present the view controller
        self.present(mainVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the corners of the buttons to become rounded instead of square
        continueProps?.layer.cornerRadius = 15
        continueProps2?.layer.cornerRadius = 15
    }
}
