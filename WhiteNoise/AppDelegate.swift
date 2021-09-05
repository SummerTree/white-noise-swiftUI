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
    var popover: NSPopover!
    
    var statusBarItem: NSStatusItem! = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength + ( /*PomoshTimer().showMenubarTimer*/true ? 70 : 0)))


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        
        NSMenu.setMenuBarVisible(true)
        
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 800, height: 600)
        popover.behavior = .transient
        popover.contentViewController = Configurator().configure()
        
        self.popover = popover
        self.popover.contentViewController?.view.window?.becomeKey()

        if let button = statusBarItem.button {
            button.image = NSImage(named: "menubar-icon")
            button.imagePosition = NSControl.ImagePosition.imageLeft
           if /*self.PoTimer.showMenubarTimer*/ true == true {
                button.title = ""//String(self.PoTimer.textForPlaybackTime(time: TimeInterval(PoTimer.timeRemaining)))
            button.font = NSFont.monospacedDigitSystemFont(ofSize: 12.0, weight: NSFont.Weight.medium)
            }
           
            button.action = #selector(togglePopover(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        

//        // Create the window and set the content view.
//        let frame = NSRect(x: 0, y: 0, width: 800, height: 600)
//        window = NSWindow(
//            contentRect: frame,
//            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        window.isReleasedWhenClosed = false
//        window.center()
//        window.setFrameAutosaveName("Main Window")
//        let contentViewController = Configurator().configure()
//        contentViewController.view.frame = frame
//        window.contentViewController = contentViewController
//        window.makeKeyAndOrderFront(nil)
    }
    
    func updateTitle(newTitle: String) {
        statusBarItem.button?.title = newTitle
    }

    func updateIcon(iconName: String) {
        statusBarItem.button?.image = NSImage(named: iconName)
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        let event = NSApp.currentEvent!

        if event.type == NSEvent.EventType.leftMouseUp {
            if let sbutton = statusBarItem.button {
                if popover.isShown {
                    popover.performClose(sender)
                } else {
                    popover.show(relativeTo: sbutton.bounds, of: sbutton, preferredEdge: NSRectEdge.minY)
                }
            }

        } else if event.type == NSEvent.EventType.rightMouseUp {
            let menu = NSMenu()
            menu.addItem(NSMenuItem(title: "Pomosh v1.0.4", action: nil, keyEquivalent: ""))
            menu.addItem(NSMenuItem.separator())
            menu.addItem(NSMenuItem(title: "Give ⭐️", action: #selector(giveStar), keyEquivalent: "s"))
            menu.addItem(withTitle: "About", action: #selector(about), keyEquivalent: "a")
            menu.addItem(withTitle: "Bug Report", action: #selector(issues), keyEquivalent: "b")
            menu.addItem(NSMenuItem.separator())
            menu.addItem(withTitle: "Quit App", action: #selector(quit), keyEquivalent: "q")

            statusBarItem.menu = menu
            statusBarItem.button?.performClick(nil)
            statusBarItem.menu = nil
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func giveStar() {
        let url = URL(string: "https://apps.apple.com/app/id1515791898?action=write-review")!
        NSWorkspace.shared.open(url)
    }

    @objc func quit() {
        NSApp.terminate(self)
    }

    @objc func about() {
        let url = URL(string: "https://pomosh.netlify.app/")!
        NSWorkspace.shared.open(url)
    }

    @objc func issues() {
        let url = URL(string: "https://github.com/stevenselcuk/Pomosh-macOS/issues")!
        NSWorkspace.shared.open(url)
    }

}

