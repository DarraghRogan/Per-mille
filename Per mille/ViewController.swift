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

    // Invoke RegEx Extension for each account type
    let validityTypeYouTube: String.ValidityType = .youTubeChannelID
    
    @objc fileprivate func handleTextChangeYouTube() {
        guard let text = youTubeField?.stringValue else { return }
        if text.isValid(validityTypeYouTube) {
            youTubeGuidanceField.isHidden = true
            youTubeLabel.stringValue = AppDelegate().defaults.object(forKey:"YouTubeChannelID") as? String ?? String()
            AppDelegate().defaults.set(youTubeField.stringValue, forKey: "YouTubeChannelID")
            youTubeField.layer?.borderWidth = 0.0
            AppDelegate().defaults.set(1, forKey: "YouTubeInUse")
            youTubeSlider.state.self = AppDelegate().defaults.object(forKey:"YouTubeInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        } else {
            youTubeGuidanceField.isHidden = false
            youTubeField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            youTubeField.layer?.borderWidth = 2.0
        }
    }
    
    let validityTypeInstagram: String.ValidityType = .instagramUsername
    
    @objc fileprivate func handleTextChangeInstagram() {
        guard let text = instagramField?.stringValue else { return }
        if text.isValid(validityTypeInstagram) {
            instagramField.layer?.borderWidth = 0.0
            AppDelegate().defaults.set(instagramField.stringValue, forKey: "InstagramUsername")
            instagramLabel.stringValue = AppDelegate().defaults.object(forKey:"InstagramUsername") as? String ?? String()
            AppDelegate().defaults.set(1, forKey: "InstagramInUse")
            instagramSlider.state.self = AppDelegate().defaults.object(forKey:"InstagramInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        } else {
            instagramField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            instagramField.layer?.borderWidth = 2.0
        }
    }
    
    let validityTypeTikTok: String.ValidityType = .tikTokUsername
    
    @objc fileprivate func handleTextChangeTikTok() {
        guard let text = tikTokField?.stringValue else { return }
        if text.isValid(validityTypeTikTok) {
            tikTokField.layer?.borderWidth = 0.0
            AppDelegate().defaults.set(tikTokField.stringValue, forKey: "TikTokUsername")
            tikTokLabel.stringValue = AppDelegate().defaults.object(forKey:"TikTokUsername") as? String ?? String()
            AppDelegate().defaults.set(1, forKey: "TikTokInUse")
            tikTokSlider.state.self = AppDelegate().defaults.object(forKey:"TikTokInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        } else {
            tikTokField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            tikTokField.layer?.borderWidth = 2.0
        }
    }

    let validityTypeTumblr: String.ValidityType = .tumblrBlogIdentifier
    
    @objc fileprivate func handleTextChangeTumblr() {
        guard let text = tumblrField?.stringValue else { return }
        if text.isValid(validityTypeTumblr) {
            tumblrField.layer?.borderWidth = 0.0
            AppDelegate().defaults.set(tumblrField.stringValue, forKey: "TumblrBlogIdentifier")
            tumblrLabel.stringValue = AppDelegate().defaults.object(forKey:"TumblrBlogIdentifier") as? String ?? String()
            AppDelegate().defaults.set(1, forKey: "TumblrInUse")
            tumblrSlider.state.self = AppDelegate().defaults.object(forKey:"TumblrInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        } else {
            tumblrField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            tumblrField.layer?.borderWidth = 2.0
        }
    }
    
    let validityTypeTwitter: String.ValidityType = .twitterHandle
    
    @objc fileprivate func handleTextChangeTwitter() {
        guard let text = twitterField?.stringValue else { return }
        if text.isValid(validityTypeTwitter) {
            twitterField.layer?.borderWidth = 0.0
            AppDelegate().defaults.set(twitterField.stringValue, forKey: "TwitterHandle")
            twitterLabel.stringValue = AppDelegate().defaults.object(forKey:"TwitterHandle") as? String ?? String()
            AppDelegate().defaults.set(1, forKey: "TwitterInUse")
            twitterSlider.state.self = AppDelegate().defaults.object(forKey:"TwitterInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        } else {
            twitterField.layer?.borderColor = CGColor.init(red: 255, green: 0, blue: 0, alpha: 100)
            twitterField.layer?.borderWidth = 2.0
        }
    }

    
    // Define connections with View Controller
    @IBOutlet weak var autorunAtStartup: NSSwitch!
    
    @IBOutlet weak var instagramField: NSTextField!
    @IBOutlet weak var instagramLabel: NSTextField!
    @IBOutlet weak var instagramSlider: NSSwitch!
    
    @IBOutlet weak var tikTokSlider: NSSwitch!
    @IBOutlet weak var tikTokLabel: NSTextField!
    @IBOutlet weak var tikTokField: NSTextField!

    @IBOutlet weak var tumblrSlider: NSSwitch!
    @IBOutlet weak var tumblrLabel: NSTextField!
    @IBOutlet weak var tumblrField: NSTextField!
    
    @IBOutlet weak var twitterSlider: NSSwitch!
    @IBOutlet weak var twitterLabel: NSTextField!
    @IBOutlet weak var twitterField: NSTextField!
    
    @IBOutlet weak var youTubeSlider: NSSwitch!
    @IBOutlet weak var youTubeLabel: NSTextField!
    @IBOutlet weak var youTubeField: NSTextField!
    @IBOutlet weak var youTubeGuidanceField: NSTextField!
    
    
    @IBOutlet weak var perMilleVersion: NSTextField!
    
    
    let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        perMilleVersion.stringValue = (nsObject.self ?? 1.00 as AnyObject) as! String
        
        autorunAtStartup.state.self = AppDelegate().defaults.object(forKey:"AutorunAtStartup") as? NSControl.StateValue ?? NSControl.StateValue(0)
        
        instagramSlider.state.self = AppDelegate().defaults.object(forKey:"InstagramInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        instagramLabel.stringValue = AppDelegate().defaults.object(forKey:"InstagramUsername") as? String ?? String()
        
//        tikTokSlider.state.self = AppDelegate().defaults.object(forKey:"TikTokInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
//        tikTokLabel.stringValue = AppDelegate().defaults.object(forKey:"TikTokUsername") as? String ?? String()
        
        tumblrSlider.state.self = AppDelegate().defaults.object(forKey:"TumblrInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        tumblrLabel.stringValue = AppDelegate().defaults.object(forKey:"TumblrBlogIdentifier") as? String ?? String()
        
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
        if AppDelegate().defaults.object(forKey:"InstagramUsername") != nil {
        AppDelegate().defaults.set(instagramSlider.state.self, forKey: "InstagramInUse")
            }
            else{
            }
        
    }
    
    @IBAction func instagramButtonClicked(_ sender: Any) {
        handleTextChangeInstagram()
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
        if AppDelegate().defaults.object(forKey:"TikTokUsername") != nil {
        AppDelegate().defaults.set(tikTokSlider.state.self, forKey: "TikTokInUse")
        }
        else{
        }
    }
    
    @IBAction func tikTokButtonClicked(_ sender: Any) {

        handleTextChangeTikTok()
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

    // Tumblr Actions
    
    @IBAction func tumblrSlider(_ sender: Any) {
            if AppDelegate().defaults.object(forKey:"TumblrBlogIdentifier") != nil {
        AppDelegate().defaults.set(tumblrSlider.state.self, forKey: "TumblrInUse")
                }
                else{
                }
    }
    
    @IBAction func tumblrButtonClicked(_ sender: Any) {
        handleTextChangeTumblr()
        if tumblrLabel.stringValue == ""{
            AppDelegate().defaults.set(0, forKey: "TumblrInUse")
        }
        else{
        }
    }
    
    @IBAction func tumblrFieldAction(_ sender: Any) {
                tumblrButtonClicked(Any.self)
    }
    
    @IBAction func tumblrHelp(_ sender: Any) {
                NSWorkspace.shared.open(URL(string: "https://tumblr.zendesk.com/hc/en-us/articles/226340048-Primary-vs-secondary-blogs")!)
    }
    
    
    // Twitter Actions
    @IBAction func twitterSlider(_ sender: Any) {
            if AppDelegate().defaults.object(forKey:"TwitterHandle") != nil {
        AppDelegate().defaults.set(twitterSlider.state.self, forKey: "TwitterInUse")
                }
                else{
                }
    }
    
    @IBAction func twitterButtonClicked(_ sender: Any) {
        handleTextChangeTwitter()
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
        if AppDelegate().defaults.object(forKey:"YouTubeChannelID") != nil {
                    AppDelegate().defaults.set(youTubeSlider.state.self, forKey: "YouTubeInUse")
        }
        else{
        }
    }
    
    @IBAction func youTubeButtonClicked(_ sender: Any) {

        handleTextChangeYouTube()
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
        NSWorkspace.shared.open(URL(string: "https://commentpicker.com/youtube-channel-id.php#youtube-channel-id")!)
    }
    
    
}

