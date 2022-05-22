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
//    var statusIcon : NSStatusBar = {
//        statusItem.button?.title = "‰"
//    }()
    
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
    
    lazy var tumblrBlogTitle : NSMenuItem = {
        return NSMenuItem(title: "Blog Title: Please Refresh", action: nil, keyEquivalent: "")
     }()
    
    lazy var tumblrPosts : NSMenuItem = {
        return NSMenuItem(title: "Lifetime ✎: Please Refresh", action: nil, keyEquivalent: "")
     }()

    lazy var tumblrLastPost : NSMenuItem = {
        return NSMenuItem(title: "Last Post: Please Refresh", action: nil, keyEquivalent: "")
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
    lazy var YouTubeLatestVideo : NSMenuItem = {
        return NSMenuItem(title: "Latest Video: Please Refresh", action: nil, keyEquivalent: "")
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

        if defaults.integer(forKey: "TumblrInUse") == 1{
        menu.addItem(
        NSMenuItem(
            title: "Tumblr...",
            action: #selector(openTumblr),
            keyEquivalent: "u"
            )
        )

        menu.addItem(tumblrBlogTitle)
        
        menu.addItem(tumblrPosts)
            
        menu.addItem(tumblrLastPost)
    
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
            
        menu.addItem(YouTubeLatestVideo)
        
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
                title: "Refresh (automatically every 2 hours)",
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
        self.instagramUsername.title = "Username: Loading, please wait (10s)"
        self.instagramFollowers.title = "Followers ጰ: Loading, please wait (10s)"
        self.instagramAverageLikes.title = "Average ♥: Loading, please wait (10s)"
        self.instagramLastPost.title = "Last Post: Loading, please wait (10s)"
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

        if defaults.integer(forKey: "TumblrInUse") == 1{
        DataLoaderTumblr().loadTumblrData()
        self.tumblrBlogTitle.title = "Blog Title: Loading, please wait (10s)"
        self.tumblrPosts.title = "Lifetime ✎: Loading, please wait (10s)"
        self.tumblrLastPost.title = "Last Post: Loading, please wait (10s)"
        }
        else{
        }
        
        if defaults.integer(forKey: "TwitterInUse") == 1{
        DataLoaderTwitter().loadTwitterData()
        self.twitterScreenName.title = "Screen Name: Loading, please wait (10s)"
        self.twitterFollowers.title = "Followers ጰ: Loading, please wait (10s)"
        self.twitterListed.title = "Listed: Loading, please wait (10s)"
        self.twitterPinnedTweet.title = "Pinned Tweet: Loading, please wait (10s)"
        }
        else{
        }
        
        if defaults.integer(forKey: "YouTubeInUse") == 1{
        DataLoaderYouTube().loadYouTubeDataChannel()
        DataLoaderYouTube().loadYouTubeDataSearch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            if youTubeDataSearch.pageInfo?.resultsPerPage == 1 {
                DataLoaderYouTube().loadYouTubeDataVideos()
            }
            else{
                self.YouTubeLatestVideo.title = "Error with passing Channel's latest video to Video API"

            }
        })
            
        self.youTubeTitle.title = "Channel: Loading, please wait (10s)"
        self.youTubeSubscribers.title = "Subscribers ጰ: Loading, please wait (10s)"
        self.youTubeViews.title = "Lifetime ▶: Loading, please wait (10s)"
        self.YouTubeLatestVideo.title = "Latest Video: Loading, please wait (20s)"
        }
        else{
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
            
            if self.defaults.integer(forKey: "InstagramInUse") == 1{
            self.instagramUsername.title = "Username: \(String(instagramData.username))"
            self.instagramFollowers.title = "Followers ጰ: \(String(format: "%U", locale: Locale.current, instagramData.follower))"
            self.instagramAverageLikes.title = "Average ♥: \(String(format: "%U", locale: Locale.current, instagramData.average_like))"
                
                let instagramLastPostLikes = instagramData.last_post?[0].like
                let instagramLastPostComment = instagramData.last_post?[0].comment
                if let instagramLastPostsVideoViews = instagramData.last_post?[0].video_view {
                    self.instagramLastPost.title = "Last Post: ▶ \(String(format: "%U", locale: Locale.current, instagramLastPostsVideoViews)), ♥ \(String(format: "%U", locale: Locale.current, instagramLastPostLikes!)), 🗨 \(String(format: "%U", locale: Locale.current, instagramLastPostComment!))"
                } else {
                    self.instagramUsername.title = "Error"
                    self.instagramFollowers.title = "Please check: "
                    self.instagramAverageLikes.title = " - If a valid Instagram username entered"
                    self.instagramLastPost.title = " - Internet connectivity & routing to RapidAPI.com"
            }
            }
            else{
            }
            
        })
    
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
      
          if self.defaults.integer(forKey: "TumblrInUse") == 1{
              
            if tumblrData.response?.blog.title != nil {
              self.tumblrBlogTitle.title = "Blog Title: \(tumblrData.response?.blog.title as! String)"
                self.tumblrPosts.title = "Lifetime ✎: \(String(format: "%U", locale: Locale.current, (tumblrData.response?.totalPosts as! Int)))"
                self.tumblrLastPost.title = "Last Post: 🗨 \(String(format: "%U", locale: Locale.current, (tumblrData.response?.posts[0].noteCount as! Int)))"
              }
              else {
                  self.tumblrBlogTitle.title = "Error"
                  self.tumblrPosts.title = "Please check: "
                  self.tumblrLastPost.title = " - If a valid Tumblr Blog URL entered & Internet connectivity"
              }
              
          }
          else{
          }
        
        })
        
        
        
  DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {
    
        if self.defaults.integer(forKey: "TwitterInUse") == 1{
            
            if twitterData.data?[0].username != nil {
                self.twitterScreenName.title = "Screen Name: \(twitterData.data?[0].username as! String)"
                self.twitterFollowers.title = "Followers ጰ: \(String(format: "%U", locale: Locale.current, (twitterData.data?[0].publicMetrics.followersCount as! Int)))"
                self.twitterListed.title = "Listed: On \(String(format: "%U", locale: Locale.current, (twitterData.data?[0].publicMetrics.listedCount as! Int))) list(s)"
            }
            else {
                self.twitterScreenName.title = "Error"
                self.twitterFollowers.title = "Please check: "
                self.twitterListed.title = " - If a valid Twitter handle entered & Internet connectivity"
                self.twitterPinnedTweet.title = " - Internet connectivity & routing to twitter.com"
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
            self.youTubeTitle.title = "Error, Check if a valid YouTube Channel ID entered & Internet connectivity"
//            self.youTubeSubscribers.title = "Please Check"
//            self.youTubeViews.title = " - if a valid YouTube Channel ID entered"
            self.YouTubeLatestVideo.title = "Error, Check if a valid YouTube Channel ID entered & Internet connectivity"
        }
            
            if let youTubeSubscriberCount: Int = Int(youTubeData.items?[0].statistics.subscriberCount! ?? "0")  {
            self.youTubeSubscribers.title = "Subscribers ጰ: \(String(format: "%U", locale: Locale.current, youTubeSubscriberCount))"
//                statusItem.button?.title = ‰
        } else {
//            self.youTubeSubscribers.title = " - "
        }
        
            if let youTubeViewCount: Int = Int(youTubeData.items?[0].statistics.viewCount ?? "0") {
            self.youTubeViews.title = "Lifetime ▶: \(String(format: "%U", locale: Locale.current, youTubeViewCount))"
        } else {
//            self.youTubeViews.title = " - Internet connectivity & routing to YouTube.com"
        }

            
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.1, execute: {

                    if youTubeDataVideos.pageInfo?.resultsPerPage == 1 {
                        let YouTubeLatestVideoViews: Int = Int(youTubeDataVideos.items?[0].statistics.viewCount ?? "0")!
                        let YouTubeLatestVideoLikes : Int = Int(youTubeDataVideos.items?[0].statistics.likeCount ?? "0")!
                        let YouTubeLatestVideoComments: Int = Int(youTubeDataVideos.items?[0].statistics.commentCount ?? "0")!
                        self.YouTubeLatestVideo.title = "Latest Video: ▶ \(String(format: "%U", locale: Locale.current, YouTubeLatestVideoViews)), ♥ \(String(format: "%U", locale: Locale.current, YouTubeLatestVideoLikes)), 🗨 \(String(format: "%U", locale: Locale.current, YouTubeLatestVideoComments))"
                     } else {
//                         self.YouTubeLatestVideo.title = "Error; if internet connectivity & Channel ID okay, problem is with YouTube API. Try later"
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
                 self.tikTokUniqueID.title = "Error, please check:"
                 }
             if let tikTokFollowers = tikTokData.data?.userInfo?.stats?.followerCount {
                 self.tikTokFollowers.title = "Followers ጰ: \(String(format: "%U", locale: Locale.current, tikTokFollowers))"
                 } else {
                 self.tikTokFollowers.title = " - If a valid TikTok username entered"
                 }
             if let tikTokHearts = tikTokData.data?.userInfo?.stats?.heartCount {
                 self.tikTokHearts.title = "Lifetime ♥: \(String(format: "%U", locale: Locale.current, tikTokHearts))"
                 } else {
                 self.tikTokHearts.title = " - Internet connectivity & routing to RapidAPI.com"
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

    @objc func openTumblr(){
        NSWorkspace.shared.open(URL(string: "https://www.tumblr.com/dashboard")!)
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
        
    // Periodically update the menu every 240 minutes to see the current info
    
    let timer = Timer.scheduledTimer(withTimeInterval: 7200.0, repeats: true) { timer in
        self.menuRefresh()
    }
    
        }
        
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
