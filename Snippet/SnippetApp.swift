//
//  SnippetApp.swift
//  Snippet
//
//  Created by Michał Pożdał on 20/02/2026.
//

import SwiftUI

@main
struct SnippetApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "scissors", accessibilityDescription: "CodeSnap")
            button.action = #selector(statusItemClicked)
        }
        
        setupMenu()
    }

    func setupMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Capture from Clipboard", action: #selector(capture), keyEquivalent: "c"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }

    @objc func statusItemClicked() {
        print("Kliknięto ikonę!")
    }

    @objc func capture() {
        print("Przechwytywanie kodu...")
    }
}
