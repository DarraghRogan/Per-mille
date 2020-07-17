//
//  ViewController.swift
//  Per mille
//
//  Created by Darragh Rogan on 07/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa
import ServiceManagement

class ViewController: NSViewController {

    @IBOutlet weak var autorunAtStartup: NSSwitch!
    
    @IBOutlet weak var instagramField: NSTextField!
    @IBOutlet weak var instagramLabel: NSTextField!
    @IBOutlet weak var instagramSlider: NSSwitch!
    
    @IBOutlet weak var tikTokSlider: NSSwitch!
    @IBOutlet weak var tikTokLabel: NSTextField!
    @IBOutlet weak var tikTokField: NSTextField!
    
    @IBOutlet weak var twitterSlider: NSSwitch!
    @IBOutlet weak var twitterLabel: NSTextField!
    @IBOutlet weak var twitterField: NSTextField!
    
    @IBOutlet weak var youTubeSlider: NSSwitch!
    @IBOutlet weak var youTubeLabel: NSTextField!
    @IBOutlet weak var youTubeField: NSTextField!
    
    @IBOutlet weak var perMilleVersion: NSTextField!
    
    
    let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        perMilleVersion.stringValue = (nsObject.self ?? 1.00 as AnyObject) as! String
        
        autorunAtStartup.state.self = AppDelegate().defaults.object(forKey:"AutorunAtStartup") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        instagramSlider.state.self = AppDelegate().defaults.object(forKey:"InstagramInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        instagramLabel.stringValue = AppDelegate().defaults.object(forKey:"InstagramUsername") as? String ?? String()
        
        tikTokSlider.state.self = AppDelegate().defaults.object(forKey:"TikTokInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        tikTokLabel.stringValue = AppDelegate().defaults.object(forKey:"TikTokUsername") as? String ?? String()
        
        twitterSlider.state.self = AppDelegate().defaults.object(forKey:"TwitterInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        twitterLabel.stringValue = AppDelegate().defaults.object(forKey:"TwitterHandle") as? String ?? String()
        
        youTubeSlider.state.self = AppDelegate().defaults.object(forKey:"YouTubeInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        youTubeLabel.stringValue = AppDelegate().defaults.object(forKey:"YouTubeChannelID") as? String ?? String()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.

        }
    }

    @IBAction func autorunAtStartupSlider(_ sender: Any) {
        let launcherAppId = "Darragh-Rogan.LauncherApplication"

        if autorunAtStartup.state.self.rawValue == 0{
             AppDelegate().defaults.set(false, forKey: "AutorunAtStartup")
            SMLoginItemSetEnabled(launcherAppId as CFString, false)
        }
        else if autorunAtStartup.state.self.rawValue == 1{
            AppDelegate().defaults.set(true, forKey: "AutorunAtStartup")
                        SMLoginItemSetEnabled(launcherAppId as CFString, true)
        }
    }
    
    
    // Instagram Actions
    @IBAction func instagramSlider(_ sender: Any) {
        
        AppDelegate().defaults.set(instagramSlider.state.self, forKey: "InstagramInUse")
//        AppDelegate().menu.removeAllItems()
        
    }
    
    @IBAction func instagramButtonClicked(_ sender: Any) {
        AppDelegate().defaults.set(instagramField.stringValue, forKey: "InstagramUsername")
        instagramLabel.stringValue = AppDelegate().defaults.object(forKey:"InstagramUsername") as? String ?? String()
        if instagramLabel.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "InstagramInUse")
        }
        else{
        }
    }
    
    @IBAction func instagramFieldAction(_ sender: Any) {
        instagramButtonClicked((Any).self)
    }
    
    @IBAction func instagramHelp(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://www.quora.com/What-is-my-Instagram-username")!)
    }
    
    // TikTok Actions
    @IBAction func tikTokSlider(_ sender: Any) {
        AppDelegate().defaults.set(tikTokSlider.state.self, forKey: "TikTokInUse")
//          AppDelegate().menu.removeAllItems()
    }
    
    @IBAction func tikTokButtonClicked(_ sender: Any) {
        AppDelegate().defaults.set(tikTokField.stringValue, forKey: "TikTokUsername")
        tikTokLabel.stringValue = AppDelegate().defaults.object(forKey:"TikTokUsername") as? String ?? String()
        if tikTokLabel.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "TikTokInUse")
        }
        else{
        }
    }
    
    @IBAction func tikTokFieldAction(_ sender: Any) {
        tikTokButtonClicked(Any.self)
    }
    
    
    @IBAction func tikTokHelp(_ sender: Any) {
                NSWorkspace.shared.open(URL(string: "https://support.tiktok.com/en/my-account-settings/change-username-default")!)
    }
    
    
    // Twitter Actions
    @IBAction func twitterSlider(_ sender: Any) {
        AppDelegate().defaults.set(twitterSlider.state.self, forKey: "TwitterInUse")
 //       AppDelegate().menu.removeAllItems()
    }
    
    @IBAction func twitterButtonClicked(_ sender: Any) {
        AppDelegate().defaults.set(twitterField.stringValue, forKey: "TwitterHandle")
        twitterLabel.stringValue = AppDelegate().defaults.object(forKey:"TwitterHandle") as? String ?? String()
        if twitterLabel.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "TwitterInUse")
        }
        else{
        }
    }

    @IBAction func twitterFieldAction(_ sender: Any) {
        twitterButtonClicked(Any.self)
    }
    
    
    @IBAction func twitterHelp(_ sender: Any) {
            NSWorkspace.shared.open(URL(string: "https://sproutsocial.com/glossary/twitter-handle/")!)
    }
    
    // YouTube Actions
    
    @IBAction func youTubeSlider(_ sender: Any) {
        AppDelegate().defaults.set(youTubeSlider.state.self, forKey: "YouTubeInUse")
//        AppDelegate().menu.removeAllItems()

    }
    
    @IBAction func youTubeButtonClicked(_ sender: Any) {
        AppDelegate().defaults.set(youTubeField.stringValue, forKey: "YouTubeChannelID")
        youTubeLabel.stringValue = AppDelegate().defaults.object(forKey:"YouTubeChannelID") as? String ?? String()
        if youTubeLabel.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "YouTubeInUse")
        }
        else{
        }
    }
    
    @IBAction func youTubeFieldAction(_ sender: Any) {
        youTubeButtonClicked(Any.self)
    }
    
    
    @IBAction func youTubeHelp(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://support.google.com/youtube/answer/3250431?hl=en")!)
    }

    
    
}

