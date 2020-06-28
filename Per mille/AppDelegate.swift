//
//  AppDelegate.swift
//  Per mille
//
//  Created by Darragh Rogan on 07/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa
import ServiceManagement

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    // Define the User Defaults to hold settings
    public let defaults = UserDefaults.standard
    
    // Define the Menu
     let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
     let menu = NSMenu()
    
    // Define the variables which need to be updated as data is loaded
    lazy var instagramFollowers : NSMenuItem = {
        return NSMenuItem(title: "Followers: Please Refresh", action: nil, keyEquivalent: "")
     }()
    lazy var instagramAverageLikes : NSMenuItem = {
        return NSMenuItem(title: "Average Likes: Please Refresh", action: nil, keyEquivalent: "")
     }()

    lazy var twitterScreenName : NSMenuItem = {
        return NSMenuItem(title: "Screen Name: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var twitterFollowers : NSMenuItem = {
        return NSMenuItem(title: "Followers: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
/*    lazy var youTubeTitle : NSMenuItem = {
        return NSMenuItem(title: "Channel: Please Refresh", action: nil, keyEquivalent: "")
     }()
 */
    lazy var youTubeViews : NSMenuItem = {
        return NSMenuItem(title: "Lifetime Views: Please Refresh", action: nil, keyEquivalent: "")
     }()
    lazy var youTubeSubscribers : NSMenuItem = {
        return NSMenuItem(title: "Subscribers: Please Refresh", action: nil, keyEquivalent: "")
     }()
    

    
    @objc func showSettings(_ sender: Any) {
            var myWindow: NSWindow? = nil
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"),bundle: nil)
        let controller = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("SettingsStoryboard")) as! NSViewController
            myWindow = NSWindow(contentViewController: controller)
            NSApp.activate(ignoringOtherApps: true)
            myWindow?.makeKeyAndOrderFront(self)
            let vc = NSWindowController(window: myWindow)
            vc.showWindow(self)
        }
    
    // The function to manually run the data loaders, by loading the data, changing the menu bar to say loading, then after a delay filling in the correct data
    
    func menuLoadOptionals() {
        
        
        
        if defaults.integer(forKey: "InstagramInUse") == 1 {
        menu.addItem(
            NSMenuItem(
                title: "Instagram...",
                action: #selector(openInstagramCreator),
                keyEquivalent: "i"
                )
            )
        
        menu.addItem(instagramFollowers)
        
        menu.addItem(instagramAverageLikes)
        
        menu.addItem(
            NSMenuItem.separator()
            )
        }
        else{
        }
        
        if defaults.integer(forKey: "TwitterInUse") == 1{
        menu.addItem(
        NSMenuItem(
            title: "Twitter...",
            action: #selector(openTwitter),
            keyEquivalent: "t"
            )
        )

        menu.addItem(twitterScreenName)
        
        menu.addItem(twitterFollowers)
        
        menu.addItem(
            NSMenuItem.separator()
            )
        }
        else{
        }
        
        if defaults.integer(forKey: "YouTubeInUse") == 1{
        menu.addItem(
        NSMenuItem(
            title: "YouTube Studio...",
            action: #selector(openYouTubeStudio),
            keyEquivalent: "y"
            )
        )
        
//        menu.addItem(youTubeTitle)
        
        menu.addItem(youTubeSubscribers)

        menu.addItem(youTubeViews)
        
        }
        else{
        }
    }
    
    @objc func menuRefresh() {
        if defaults.integer(forKey: "InstagramInUse") == 1{
            DataLoaderInstagram().loadInstagramData()
            self.instagramFollowers.title = "Followers: Loading, please wait"
            self.instagramAverageLikes.title = "Average Likes: Loading, please wait"
        }
        else{
        }
    
        if defaults.integer(forKey: "TwitterInUse") == 1{
        DataLoaderTwitter().loadTwitterData()
        self.twitterScreenName.title = "Screen Name: Loading, please wait"
        self.twitterFollowers.title = "Followers: Loading, please wait"
        }
        else{
        }
        
        if defaults.integer(forKey: "YouTubeInUse") == 1{
        DataLoaderYouTube().loadYouTubeData()
//        self.youTubeTitle.title = "Channel: Loading, please wait"
        self.youTubeSubscribers.title = "Subscribers: Loading, please wait"
        self.youTubeViews.title = "Lifetime Views: Loading, please wait"
        }
        else{
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
            
            if self.defaults.integer(forKey: "InstagramInUse") == 1{
            self.instagramFollowers.title = "Followers: \(String(instagramData.follower))"
            self.instagramAverageLikes.title = "Average Likes: \(String(instagramData.average_like))"
            }
            else{
            }
            
            if self.defaults.integer(forKey: "TwitterInUse") == 1{
            self.twitterScreenName.title = "Screen Name: \(String(twitterData.screen_name))"
            self.twitterFollowers.title = "Followers: \(String(twitterData.followers))"
            }
            else{
            }
                
            if self.defaults.integer(forKey: "YouTubeInUse") == 1{
//            self.youTubeTitle.title = "Title: \(youTubeData.items?[0].snippet.title)"
            if let youTubeSubscriberCount = youTubeData.items?[0].statistics.subscriberCount {
                self.youTubeSubscribers.title = "Subscribers: \(youTubeSubscriberCount)"
            } else {
                self.youTubeSubscribers.title = "Error - do you have internet connectivity & is your Channel ID correct?"
            }
            
            if let youTubeViewCount = youTubeData.items?[0].statistics.viewCount {
                self.youTubeViews.title = "Lifetime Views: \(youTubeViewCount)"
            } else {
                self.youTubeViews.title = "Error - do you have internet connectivity & is your Channel ID correct?"
            }
            }
            else{
            }
            
        })

    }

    
// Define how to open web addresses from menu

    @objc func openInstagramCreator(){
        NSWorkspace.shared.open(URL(string: "https://www.instagram.com")!)
    }

    @objc func openTwitter(){
        NSWorkspace.shared.open(URL(string: "https://analytics.twitter.com")!)
    }
    
    @objc func openYouTubeStudio(){
        NSWorkspace.shared.open(URL(string: "https://studio.youtube.com")!)
 }

    @objc func openAboutPermille(){
        NSWorkspace.shared.open(URL(string: "https://permille.app")!)
 }


   public func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    
// interact with launcher app from https://theswiftdev.com/how-to-launch-a-macos-app-at-login/
    let launcherAppId = "Darragh-Rogan.LauncherApplication"
    let runningApps = NSWorkspace.shared.runningApplications
    let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty

    SMLoginItemSetEnabled(launcherAppId as CFString, true)

    if isRunning {
        DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
    }
        
    // define the user defaults
//    AppDelegate().defaults.set(false, forKey: "InstagramInUse")
//    AppDelegate().defaults.set(false, forKey: "TwitterInUse")
//    AppDelegate().defaults.set(true, forKey: "YouTubeInUse")
    
// Run the dataloaders at app startup

        menuRefresh()
    
// Periodically update the menu every 30 minutes to see the current info
        DispatchQueue.main.asyncAfter(deadline: .now() + 1800.0, execute: {
            self.menuRefresh()
        })
    
    // load the optional menu items at app startup
        menuLoadOptionals()
    
// draw in the non optional menu items at app startup
        statusItem.button?.title = "‰"
        //String(DataLoader().newsData.totalResults)
        statusItem.button?.target = self
        statusItem.menu = menu
            
        menu.addItem(
            NSMenuItem.separator()
            )

        menu.addItem(
            NSMenuItem(
                title: "Refresh (automatically every 30 mins)",
                action: #selector(AppDelegate.menuRefresh),
                keyEquivalent: "r"
                )
            )
        
        menu.addItem(
            NSMenuItem(
                title: "Settings...",
                action: #selector(AppDelegate.showSettings),
                keyEquivalent: "s"
                )
            )
        

        
        menu.addItem(
            NSMenuItem(
                title: "About ‰ Per mille...",
                action: #selector(AppDelegate.openAboutPermille),
                keyEquivalent: "a"
                )
            )
        
        menu.addItem(
            NSMenuItem(
                title: "Quit",
                action: Selector("terminate:"),
                keyEquivalent: "q")
                    )

    
        }

        
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
