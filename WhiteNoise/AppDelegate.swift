//
//  AppDelegate.swift
//  WhiteNoise
//
//  Created by liyipeng on 2021/9/3.
//  Copyright © 2021 Alexandra Bashkirova. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.

        // Create the window and set the content view.
        let frame = NSRect(x: 0, y: 0, width: 800, height: 600)
        window = NSWindow(
            contentRect: frame,
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        let contentViewController = Configurator().configure()
        contentViewController.view.frame = frame
        window.contentViewController = contentViewController
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

