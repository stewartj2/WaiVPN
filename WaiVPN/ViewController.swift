//
//  ViewController.swift
//  WaiVPN
//
//  Created by Jaden on 25/07/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//
//  App ID - ca-app-pub-6209038126086457/7176257644
//  Test Unit ID - ca-app-pub-3940256099942544/2934735716
//


// Import all necessary frameworks
import UIKit
import Security
import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import AVFoundation
import UserNotifications

// Third party frameworks
import GoogleMobileAds
import RPCircularProgress



class ViewController: UIViewController {
    
    // struct that defines the trackColor for the On tint in the FunSettingsController
    struct colors {
        static let trackColor = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
    }
    
    
    // Decleare that the intersitial variable is GADInterstital so I dont have to define that when using it.
    var interstitial: GADInterstitial!
    var audioPlayer:  AVAudioPlayer!
    
    var timerisRunning = true
    
    
    
    // Declare weak outlet variables which is being used inside the interface builder.
    @IBOutlet weak var ConnectToVPN: UIButton!
    @IBOutlet weak var VPNLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var logWindow: UITextView!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var progressRing: RPCircularProgress!
    @IBOutlet weak var progressRingAbove: RPCircularProgress!
    @IBOutlet weak var serverLocation: UIBarButtonItem!
    @IBOutlet weak var protocolState: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    // Timer variable to show time in Verbose mode.
    let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .full, timeStyle: .full)
    
    // Constant that stores the shared user notification center object
    let notificationCenter = UNUserNotificationCenter.current()

    
    // Stores an ad in the background to be displayed at another time when needed.
    func LoadAdInBackground() -> GADInterstitial  {
        let inter = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/5135589807")
        
        // Get a request from AdMob servers to load the ad.
        inter.load(GADRequest())
        
        return inter
    }
    
    
    // Show interstitial video ad
    func showVideoAdOnConnect() {
        
    interstitial.present(fromRootViewController: self)
        
        logWindow.text += "\n[+] Successfully loaded interstitial ad."
    }
    
    // When user clicks on the "Connect" button everything in this function will run
    @IBAction func ConnectToVPN(_ sender: Any) {
        
        // start the timer that displays inside the button
        timerisRunning = true
        
        // function that stores all the code for the timer
        func startTimer() {
            
            // Date() provides methods for creating dates, comparing dates and calculating time intervals between dates.
            let startTime = Date()
            
            // this creates an unnamed variable as I do not need to customize is again in the future. It makes a scheduled timer where every 1 second it updates. Repeats means that it will repeat the iteration again every 1 second, if false it will just stop at the first second
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                
                let now = Date()
                
                
                let components = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime, to: now)
                
                let hoursPortion = components.hour
                let minutesPortion = components.minute
                let secondsPortion = components.second
                
               // sets the format of the timer as 00:00:00 (hour:minutes:seconds)
                self.timerLabel.text = String(format: "%02i:%02i:%02i",hoursPortion!, minutesPortion!, secondsPortion!)
                
            }
        }
        startTimer()
      
        // while it is connecting, it will disable the the user from clicking on it
        ConnectToVPN.isUserInteractionEnabled = false
        
        // display text as below in the UIToolbar
        serverLocation?.title = "Location: Masterton, New Zealand"
        
        // change the color of the rings in the circle
        progressRingAbove?.progressTintColor            = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
        progressRing?.progressTintColor                 = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
        progressRingAbove?.trackTintColor               = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 0.0)
        progressRing?.trackTintColor                    = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 0.0)
        
        // change the "Connect" text to "Connecting"
        VPNLabel?.text = "Connecting"
            
        // Show the timer inside the circle
        self.timerLabel.isHidden = false
            
        // after 7 seconds, all this code will be run.
        _ = Timer.scheduledTimer(withTimeInterval: 7.0, repeats: false) { timerConnect in
            
            //change colours of the circles
            self.progressRingAbove?.trackTintColor   = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
            self.progressRing?.trackTintColor        = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
            
            //stop the cricles from spinning indeterminately
            self.progressRing.enableIndeterminate(false)
            self.progressRingAbove.enableIndeterminate(false)
                
                
            // just display below in the UIToolbar (just a placeholder until server is setup)
            self.serverLocation?.title = "Error: Timed out."
            
            // It will show that the there was an error connecting to the server inside the log window if verbose mode is turned on (just a placeholder until server is setup)
            self.logWindow?.text += "\n[-] Error connecting to server: Timed out.\n"
            
            // display that vpn is ready to connect again after it encountered an error
            self.logWindow?.text += "\n[+] WaiVPN is ready to connect."
            self.VPNLabel?.text = "Connect"
            
            
            //change this to true once vpn is functional
            self.timerLabel?.isHidden = false
            
            // make the connect button clickable again after 7 seconds
            self.ConnectToVPN?.isUserInteractionEnabled = true
                
           
        }
            
        
        // What the log window will look like when I set up the server.
        logWindow?.text += "\n -------------------------------------------------\n"
        logWindow?.text += "\n[+] Trying to connect to 104.908.889.1\n"
        logWindow?.text += "\n[+] Pinging 104.908.889.1 at 1ms\n"
        
       
        // Trigger haptic touch when user clicks on Connect.
        if #available(iOS 13.0, *) {
        // Only use the 'rigid' strength if user is on ios 13
            
            // set a constant that stores the feedback stength.
            let feedback = UIImpactFeedbackGenerator(style: .rigid)
            
            // i do not know why it needs to prepare just before occuring but thats what documentation says to do.
            feedback.prepare()
            
            // do the feedback
            feedback.impactOccurred()
        }
            
        else {
        // if user is on any ios below 13, use the heavy feedback strength
            
            // set a constant that stores the feedback strength
            let feedback = UIImpactFeedbackGenerator(style: .heavy)
            feedback.prepare()
            feedback.impactOccurred()
        }
            
        self.progressRing?.enableIndeterminate()
        self.progressRingAbove?.enableIndeterminate()
        
        self.progressRing?.indeterminateDuration      = 1.0
        self.progressRingAbove?.indeterminateDuration = 1.0
        
        
        
        // Play jordans car noises (fun settings)
        let pathToSound = Bundle.main.path(forResource: "jordanCarNoise", ofType: "mp3")
        
        // store the path of where the file is stored
        let url = URL(fileURLWithPath: pathToSound!)
        
        // if switch is on in fun settings table view controller then do these lines below
        if UserDefaults.standard.bool(forKey: "jordanStateFun") == true {
            logWindow?.text += "\n[+] Playing jordanCarNoise.mp3\n"
            
            // try and play the .mp3
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.play()
            }
            
            // if it could not play .mp3 for any reason give an error in the console
            catch {
                print("couldnt play jordans car noises: \(error)")
                
            }
        }

 
    }
    
    // when view controller appears run the code in this function
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        serverLocation?.title = "Location: Masterton, New Zealand"
         
        let content = UNMutableNotificationContent()
        
        // after 10 seconds, display a notification (only works when the app is closed)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // if user chooses udp as protocol, change protocolstate title in nav bar to "UDP"
        if UserDefaults.standard.bool(forKey: "udpState") == true {
            protocolState.title = "UDP"
        }
        
        // else, change to TCP
        else {
            protocolState.title = "TCP"
        }
        
        // display notification when app closes (just a debug thing)
        content.title = "Exited app"
        content.body = "Exit: 10.0 seconds"
        
        
        if UserDefaults.standard.bool(forKey: "rileeStateFun") {
            ConnectToVPN.setImage(UIImage(named: "rileeFace.png"), for: .normal)
        }
        else if UserDefaults.standard.bool(forKey: "ethanStateFun") {
            ConnectToVPN.setImage(UIImage(named: "ethanFace.png"), for: .normal)
        }
        else if UserDefaults.standard.bool(forKey: "jacobStateFun") {
            ConnectToVPN.setImage(UIImage(named: "jacobFace.png"), for: .normal)
        }
        else if UserDefaults.standard.bool(forKey: "kodeeStateFun") {
            ConnectToVPN.setImage(UIImage(named: "kodeeFace.png"), for: .normal)
        }
        else {
            ConnectToVPN.setImage(nil, for: .normal)
        }
        
        if UserDefaults.standard.bool(forKey: "verboseStateFun") == true {
            logWindow?.isHidden = false
        }
        else {
            logWindow?.isHidden = true
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // The commented code below crashes app on boot because of an unwrapping optional error, will try to find the fix asap.
        //protocolState.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue Light", size: 19)], for: .normal)
        
        
        // If user is on iOS 12+ it will use NWPathMonitor to check if user on a internet connection. This will be updated once I get a server up and running.
        if #available(iOS 12.0, *)
        {
            
            // NWPathMonitor allows the device to monitor and react to network changes
            let monitor = NWPathMonitor()
            
            // creates a new dispatch queue, a dispatch queue allows management of tasks on the main or background thread
            let queue = DispatchQueue(label: "InternetConnectionMonitor")

            
                monitor.pathUpdateHandler = { pathUpdateHandler in
                    
                    // if device has internet or lte ON
                    if pathUpdateHandler.status == .satisfied {
                        print("Internet connection is on.")
                        
                    }
                    
                    // if decvice has no internet or lte
                    else {
                        print("There's no internet connection.")
                        self.logWindow?.text += "\n[-] You are not connected to a internet connection."
                        
                        // displays an alert controller to say internet connecrion coukd not be found
                        let alert = UIAlertController(title: "Could not find an internet connection", message: "Please connect to a network in order to connect."  , preferredStyle: .alert)
                        
                        // add 'ok' button to the alert controller
                        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        // present alert controller to the screen
                        self.present(alert, animated: true)
                    }
                }
                
                
                monitor.start(queue: queue)
        }
        
        // hide the timer
        timerLabel?.isHidden = true
        
        // thickness of circle
        progressRing?.thicknessRatio = 0.02
        
        
        progressRingAbove?.trackTintColor = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
        progressRing?.trackTintColor      = UIColor(red: 23/255.0, green: 18/255.0, blue: 240/255.0, alpha: 1.0)
           

        
        
        // Log window
        // Displays the time / date inside the log window when the app starts.
        logWindow?.text += timestamp + "\n"
        logWindow?.text += "\n(Log Window is not finished, please do not expect much)"
        logWindow?.text += "\n \(NEVPNIKEv2IntegrityAlgorithm.self)"
        // Banner ad
        // Tells the app to use this AdMob id
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController     = self
        
        // Sends a request from AdMob servers to get an ad.
        bannerView.load(GADRequest())
        
        
        // Interstitial video ad
        // Tells the app to use this AdMob id
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/5135589807")
        // Sends a request to admob server to get an ad.
        interstitial.load(GADRequest())
        
    
      
        
        // Rest of app
        // makes the connect button a real circle so you cant touch the invisible corners. This is because even if you set it to look like a circle, the radius is still a square.
        ConnectToVPN.layer.masksToBounds  = false
        ConnectToVPN.layer.cornerRadius   = ConnectToVPN.frame.height/2
        ConnectToVPN.clipsToBounds        = true
        
        // Debug / verbose mode is for me to debug what is wrong in the app. It may not be in when I release this.
        // If my prefernce for debug mode is true. It will load the log window when the app starts.
        if UserDefaults.standard.bool(forKey: "debugStateFun") == true {
            logWindow?.isHidden            = false
            
        }
            
        // If my preference for debug mode is false. It wont load the log window when the app starts.
        else {
            logWindow?.isHidden            = true
        }
        
       
    }
    
    
}
