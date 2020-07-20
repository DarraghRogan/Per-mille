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
    lazy var instagramUsername : NSMenuItem = {
        return NSMenuItem(title: "Username: Please Refresh", action: nil, keyEquivalent: "")
     }()
    lazy var instagramFollowers : NSMenuItem = {
        return NSMenuItem(title: "Followers ጰ: Please Refresh", action: nil, keyEquivalent: "")
     }()
    lazy var instagramAverageLikes : NSMenuItem = {
        return NSMenuItem(title: "Average ♥: Please Refresh", action: nil, keyEquivalent: "")
     }()
    lazy var instagramLastPost : NSMenuItem = {
        return NSMenuItem(title: "Last Post: Please Refresh", action: nil, keyEquivalent: "")
     }()

    lazy var tikTokUniqueID : NSMenuItem = {
        return NSMenuItem(title: "Username: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var tikTokFollowers : NSMenuItem = {
        return NSMenuItem(title: "Followers ጰ: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var tikTokHearts : NSMenuItem = {
        return NSMenuItem(title: "Lifetime ♥: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var twitterScreenName : NSMenuItem = {
        return NSMenuItem(title: "Screen Name: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var twitterFollowers : NSMenuItem = {
        return NSMenuItem(title: "Followers ጰ: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var twitterListed : NSMenuItem = {
        return NSMenuItem(title: "Listed: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var twitterPinnedTweet : NSMenuItem = {
        return NSMenuItem(title: "Pinned Tweet: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var youTubeTitle : NSMenuItem = {
        return NSMenuItem(title: "Channel: Please Refresh", action: nil, keyEquivalent: "")
     }()
 
    lazy var youTubeViews : NSMenuItem = {
        return NSMenuItem(title: "Lifetime ▶: Please Refresh", action: nil, keyEquivalent: "")
     }()
    lazy var youTubeSubscribers : NSMenuItem = {
        return NSMenuItem(title: "Subscribers ጰ: Please Refresh", action: nil, keyEquivalent: "")
     }()
    lazy var youTubeLastVideo : NSMenuItem = {
        return NSMenuItem(title: "Last Video: Please Refresh", action: nil, keyEquivalent: "")
     }()

    
    @objc func showPreferences(_ sender: Any) {
            var myWindow: NSWindow? = nil
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"),bundle: nil)
        let controller = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("PreferencesStoryboard")) as! NSViewController
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
            
        menu.addItem(instagramUsername)
            
        menu.addItem(instagramFollowers)
        
        menu.addItem(instagramAverageLikes)
            
        menu.addItem(instagramLastPost)
        
        menu.addItem(
            NSMenuItem.separator()
            )
        }
        else{
        }
        
        if defaults.integer(forKey: "TikTokInUse") == 1 {
        menu.addItem(
            NSMenuItem(
                title: "TikTok...",
                action: #selector(openTikTok),
                keyEquivalent: "k"
                )
            )
        
        menu.addItem(tikTokUniqueID)
            
        menu.addItem(tikTokFollowers)
        
        menu.addItem(tikTokHearts)
        
        menu.addItem(
            NSMenuItem.separator()
            )
        }
        else{
        }
        
        if defaults.integer(forKey: "TwitterInUse") == 1{
        menu.addItem(
        NSMenuItem(
            title: "Twitter Analytics...",
            action: #selector(openTwitter),
            keyEquivalent: "t"
            )
        )

        menu.addItem(twitterScreenName)
        
        menu.addItem(twitterFollowers)
            
        menu.addItem(twitterListed)
            
        menu.addItem(twitterPinnedTweet)
        
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
        
        menu.addItem(youTubeTitle)
        
        menu.addItem(youTubeSubscribers)

        menu.addItem(youTubeViews)
            
        menu.addItem(youTubeLastVideo)
        
        }
        else{
        }
    }
    
    func menuLoadNonOptionals(){
        statusItem.button?.title = "‰"
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
                title: "Preferences...",
                action: #selector(AppDelegate.showPreferences),
                keyEquivalent: ","
                )
            )
        
        menu.addItem(
            NSMenuItem(
                title: "Review ‰ Per mille...",
                action: #selector(AppDelegate.reviewPermille),
                keyEquivalent: "e"
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
    
    @objc func menuRefresh() {
        menu.removeAllItems()
        menuLoadOptionals()
        menuLoadNonOptionals()
        
        if defaults.integer(forKey: "InstagramInUse") == 1{
            DataLoaderInstagram().loadInstagramData()
            self.instagramUsername.title = "Username: Loading, please wait"
            self.instagramFollowers.title = "Followers ጰ: Loading, please wait"
            self.instagramAverageLikes.title = "Average ♥: Loading, please wait"
            self.instagramLastPost.title = "Last Post: Loading, please wait"
        }
        else{
        }

        if defaults.integer(forKey: "TikTokInUse") == 1{
        DataLoaderTikTok().loadTikTokData()
        self.tikTokUniqueID.title = "Username: Loading, please wait (20s)"
        self.tikTokFollowers.title = "Followers ጰ: Loading, please wait (20s)"
        self.tikTokHearts.title = "Lifetime ♥: Loading, please wait (20s)"
        }
        else{
        }
        
        if defaults.integer(forKey: "TwitterInUse") == 1{
        DataLoaderTwitter().loadTwitterData()
        self.twitterScreenName.title = "Screen Name: Loading, please wait"
        self.twitterFollowers.title = "Followers ጰ: Loading, please wait"
        self.twitterListed.title = "Listed: Loading, please wait"
        self.twitterPinnedTweet.title = "Pinned Tweet: Loading, please wait"
        }
        else{
        }
        
        if defaults.integer(forKey: "YouTubeInUse") == 1{
        DataLoaderYouTube().loadYouTubeDataChannel()
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            DataLoaderYouTube().loadYouTubeDataSearch()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            DataLoaderYouTube().loadYouTubeDataVideos()
        })
            
        self.youTubeTitle.title = "Channel: Loading, please wait"
        self.youTubeSubscribers.title = "Subscribers ጰ: Loading, please wait"
        self.youTubeViews.title = "Lifetime ▶: Loading, please wait"
        self.youTubeLastVideo.title = "Last Video: Loading, please wait"
        }
        else{
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
            
            if self.defaults.integer(forKey: "InstagramInUse") == 1{
            self.instagramUsername.title = "Username: \(String(instagramData.username))"
            self.instagramFollowers.title = "Followers ጰ: \(String(format: "%U", locale: Locale.current, instagramData.follower))"
            self.instagramAverageLikes.title = "Average ♥: \(String(format: "%U", locale: Locale.current, instagramData.average_like))"
                
                let instagramLastPostLikes = instagramData.last_post?[0].like
                let instagramLastPostComment = instagramData.last_post?[0].comment
                if let instagramLastPostsVideoViews = instagramData.last_post?[0].video_view {
                    self.instagramLastPost.title = "Last Post: ▶ \(String(format: "%U", locale: Locale.current, instagramLastPostsVideoViews)), ♥ \(String(format: "%U", locale: Locale.current, instagramLastPostLikes!)), 🗨 \(String(format: "%U", locale: Locale.current, instagramLastPostComment!))"
                } else {
                    self.instagramLastPost.title = "Error; if internet connectivity & Username okay, problem is with RapidAPI. Try later"
            }
            }
            else{
            }
            
        })
        
        
  DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
    
        if self.defaults.integer(forKey: "TwitterInUse") == 1{
            
            if twitterData.data?[0].username != nil {
                self.twitterScreenName.title = "Screen Name: \(twitterData.data?[0].username as! String)"
                self.twitterFollowers.title = "Followers ጰ: \(String(format: "%U", locale: Locale.current, (twitterData.data?[0].publicMetrics.followersCount as! Int)))"
                self.twitterListed.title = "Listed: On \(String(format: "%U", locale: Locale.current, (twitterData.data?[0].publicMetrics.listedCount as! Int))) list(s)"
            }
            else {
                self.twitterScreenName.title = "Error; if internet connectivity & username okay, problem is with Twitter API. Try later"
                self.twitterFollowers.title = "Error; if internet connectivity & username okay, problem is with Twitter API. Try later"
            }
            
            if twitterData.includes?.tweets[0].publicMetrics.likeCount != nil {
                self.twitterPinnedTweet.title = "Pinned Tweet: ♺ \(String(format: "%U", locale: Locale.current, (twitterData.includes?.tweets[0].publicMetrics.retweetCount as! Int))), ❝❞ \(String(format: "%U", locale: Locale.current, (twitterData.includes?.tweets[0].publicMetrics.quoteCount as! Int))), ♥ \(String(format: "%U", locale: Locale.current, (twitterData.includes?.tweets[0].publicMetrics.likeCount as! Int))), 🗨 \(String(format: "%U", locale: Locale.current, (twitterData.includes?.tweets[0].publicMetrics.replyCount as? Int ?? 0)))"
            }
            else {
                self.twitterPinnedTweet.title = "Pinned Tweet: None"
            }
            
            
            
        }
        else{
        }
            
        if self.defaults.integer(forKey: "YouTubeInUse") == 1{

        if let youTubeTitle = youTubeData.items?[0].snippet.title {
            self.youTubeTitle.title = "Title: \(youTubeTitle)"
        } else {
            self.youTubeTitle.title = "Error; if internet connectivity & Channel ID okay, problem is with YouTube API. Try later"
        }
            
        if let youTubeSubscriberCount = youTubeData.items?[0].statistics.subscriberCount {
            self.youTubeSubscribers.title = "Subscribers ጰ: \(youTubeSubscriberCount)"
        } else {
            self.youTubeSubscribers.title = "Error; if internet connectivity & Channel ID okay, problem is with YouTube API. Try later"
        }
        
        if let youTubeViewCount = youTubeData.items?[0].statistics.viewCount {
            self.youTubeViews.title = "Lifetime ▶: \(youTubeViewCount)"
        } else {
            self.youTubeViews.title = "Error; if internet connectivity & Channel ID okay, problem is with YouTube API. Try later"
        }

            
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.1, execute: {

                    if youTubeDataVideos.pageInfo?.resultsPerPage == 1 {
                        let youTubeLastVideoViews = youTubeDataVideos.items?[0].statistics.viewCount as! String
                         let youTubeLastVideoLikes = youTubeDataVideos.items?[0].statistics.likeCount as! String
                        let youTubeLastVideoComments = youTubeDataVideos.items?[0].statistics.commentCount as? String ?? "0"
                        self.youTubeLastVideo.title = "Last Video: ▶ \(youTubeLastVideoViews), ♥ \(youTubeLastVideoLikes), 🗨 \(youTubeLastVideoComments)"
                     } else {
                         self.youTubeLastVideo.title = "Error; if internet connectivity & Channel ID okay, problem is with YouTube API. Try later"
                     }

                })
 
            
        }
        else{
        }

    })
// ☺
          DispatchQueue.main.asyncAfter(deadline: .now() + 20.0, execute: {
        if self.defaults.integer(forKey: "TikTokInUse") == 1{
             if let tikTokUsername = tikTokData.data?.userInfo?.user?.uniqueID {
                 self.tikTokUniqueID.title = "Username: \(tikTokUsername)"
                 } else {
                 self.tikTokUniqueID.title = "Error; if internet connectivity & Username okay, problem is with RapidAPI. Try later"
                 }
             if let tikTokFollowers = tikTokData.data?.userInfo?.stats?.followerCount {
                 self.tikTokFollowers.title = "Followers ጰ: \(String(format: "%U", locale: Locale.current, tikTokFollowers))"
                 } else {
                 self.tikTokFollowers.title = "Error; if internet connectivity & Username okay, problem is with RapidAPI. Try later"
                 }
             if let tikTokHearts = tikTokData.data?.userInfo?.stats?.heartCount {
                 self.tikTokHearts.title = "Lifetime ♥: \(String(format: "%U", locale: Locale.current, tikTokHearts))"
                 } else {
                 self.tikTokHearts.title = "Error; if internet connectivity & Username okay, problem is with RapidAPI. Try later"
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

    @objc func openTikTok(){
        NSWorkspace.shared.open(URL(string: "https://www.tiktok.com")!)
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
    
       @objc func reviewPermille(){
                NSWorkspace.shared.open(URL(string: "itms-apps://itunes.apple.com/developer/id1518488644")!)
    }


   public func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    
// interact with launcher app from https://theswiftdev.com/how-to-launch-a-macos-app-at-login/
    let launcherAppId = "Darragh-Rogan.LauncherApplication"
    let runningApps = NSWorkspace.shared.runningApplications
    let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty

    SMLoginItemSetEnabled(launcherAppId as CFString, self.defaults.bool(forKey: "AutorunAtStartup"))

    if isRunning {
        DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
    }
        
    
    // load the optional menu items at app startup
        menuLoadOptionals()
    
// draw in the non optional menu items at app startup
        menuLoadNonOptionals()
    
    
    // Run the dataloaders at app startup

            menuRefresh()
        
    // Periodically update the menu every 30 minutes to see the current info
    
    let timer = Timer.scheduledTimer(withTimeInterval: 1800.0, repeats: true) { timer in
        self.menuRefresh()
    }
    
        }
        
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
