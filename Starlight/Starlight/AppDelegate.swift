//
//  AppDelegate.swift
//  Starlight
//
//  Created by Pouya Kary on 7/24/1397 .
//  Copyright © 1397 Pouya Kary. All rights reserved.
//

import Cocoa

var server = StarlightServer( )

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        server.start()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        server.stop()
    }
}
