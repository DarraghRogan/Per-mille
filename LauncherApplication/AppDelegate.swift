//
//  AppDelegate.swift
//  LauncherApplication
//
//  Created by Darragh Rogan on 27/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @objc func terminate() {
        NSApp.terminate(nil)
    }
    
    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let mainAppIdentifier = "Darragh-Rogan.Per-mille"
                let runningApps = NSWorkspace.shared.runningApplications
                let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

                if !isRunning {
                    DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killLauncher, object: mainAppIdentifier)

                    let path = Bundle.main.bundlePath as NSString
                    var components = path.pathComponents
                    components.removeLast()
                    components.removeLast()
                    components.removeLast()
                    components.append("MacOS")
                    components.append("Per-mille") //main app name

                    let newPath = NSString.path(withComponents: components)

                    NSWorkspace.shared.launchApplication(newPath)
                }
                else {
                    self.terminate()
                }
            }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
