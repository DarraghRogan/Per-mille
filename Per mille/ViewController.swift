//
//  ViewController.swift
//  Per mille
//
//  Created by Darragh Rogan on 07/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var instagramField: NSTextField!
    @IBOutlet weak var instagramLabel: NSTextField!
    @IBOutlet weak var instagramSlider: NSSwitch!
    
    @IBOutlet weak var twitterSlider: NSSwitch!
    @IBOutlet weak var twitterLabel: NSTextField!
    @IBOutlet weak var twitterField: NSTextField!
    
    @IBOutlet weak var youTubeSlider: NSSwitch!
    @IBOutlet weak var youTubeLabel: NSTextField!
    @IBOutlet weak var youTubeField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        instagramSlider.state.self = AppDelegate().defaults.object(forKey:"InstagramInUse") as? NSControl.StateValue ?? NSControl.StateValue(0)
        instagramLabel.stringValue = AppDelegate().defaults.object(forKey:"InstagramUsername") as? String ?? String()
        
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

    // Instagram Actions
    @IBAction func instagramSlider(_ sender: Any) {
        AppDelegate().defaults.set(instagramSlider.state.self, forKey: "InstagramInUse")
//        print(AppDelegate().defaults.object(forKey:"InstagramInUse") as? NSSwitch)
        AppDelegate().menuLoadOptionals()
    }
    
    @IBAction func instagramButtonClicked(_ sender: Any) {
        AppDelegate().defaults.set(instagramField.stringValue, forKey: "InstagramUsername")
        instagramLabel.stringValue = AppDelegate().defaults.object(forKey:"InstagramUsername") as? String ?? String()
    }
    
    @IBAction func instagramFieldAction(_ sender: Any) {
        instagramButtonClicked((Any).self)
    }
    
    @IBAction func instagramHelp(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://www.quora.com/What-is-my-Instagram-username")!)
    }
    
    
    // Twitter Actions
    @IBAction func twitterSlider(_ sender: Any) {
        AppDelegate().defaults.set(twitterSlider.state.self, forKey: "TwitterInUse")
 //       print(AppDelegate().defaults.object(forKey:"TwitterInUse") as? NSSwitch)
        AppDelegate().menuLoadOptionals()
    }
    
    @IBAction func twitterButtonClicked(_ sender: Any) {
        AppDelegate().defaults.set(twitterField.stringValue, forKey: "TwitterHandle")
        twitterLabel.stringValue = AppDelegate().defaults.object(forKey:"TwitterHandle") as? String ?? String()
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
//        print(AppDelegate().defaults.object(forKey:"YouTubeInUse") as? NSSwitch)
        AppDelegate().menuLoadOptionals()

    }
    
    @IBAction func youTubeButtonClicked(_ sender: Any) {
        AppDelegate().defaults.set(youTubeField.stringValue, forKey: "YouTubeChannelID")
        youTubeLabel.stringValue = AppDelegate().defaults.object(forKey:"YouTubeChannelID") as? String ?? String()
    }
    
    @IBAction func youTubeFieldAction(_ sender: Any) {
        youTubeButtonClicked(Any.self)
    }
    
    
    @IBAction func youTubeHelp(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://support.google.com/youtube/answer/3250431?hl=en")!)
    }
    
    
}

