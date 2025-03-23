//
//  SXCleanByApp.swift
//  SXCleanBy
//
//  Created by Роман Беловицкий on 20.03.2025.




/*
________       ___    ___ ________  ___       _______   ________  ________   ________      ___    ___
|\   ____\     |\  \  /  /|\   ____\|\  \     |\  ___ \ |\   __  \|\   ___  \|\   __  \    |\  \  /  /|
\ \  \___|_    \ \  \/  / | \  \___|\ \  \    \ \   __/|\ \  \|\  \ \  \\ \  \ \  \|\ /_   \ \  \/  / /
\ \_____  \    \ \    / / \ \  \    \ \  \    \ \  \_|/_\ \   __  \ \  \\ \  \ \   __  \   \ \    / /
 \|____|\  \    /     \/   \ \  \____\ \  \____\ \  \_|\ \ \  \ \  \ \  \\ \  \ \  \|\  \   \/  /  /
   ____\_\  \  /  /\   \    \ \_______\ \_______\ \_______\ \__\ \__\ \__\\ \__\ \_______\__/  / /
  |\_________\/__/ /\ __\    \|_______|\|_______|\|_______|\|__|\|__|\|__| \|__|\|_______|\___/ /
  \|_________||__|/ \|__|                                                                \|___|/
                                                                                                      
    
*/




import SwiftUI
import Cocoa

//global class

class GlobalDataModel : ObservableObject {
    
    @Published var allDefaultPaths: [String] = []
    
    
}

//delegate to make custom app bar option
class AppDelegate: NSObject, NSApplicationDelegate {
    private var aboutBoxWindowController: NSWindowController?

    func showAboutPanel() {
        if aboutBoxWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable,/* .resizable,*/ .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = "SXMac editor"
            window.contentView = NSHostingView(rootView: AboutView())
            aboutBoxWindowController = NSWindowController(window: window)
        }

        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }
}

@main
struct SXCleanByApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var globaldata = GlobalDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView() 
                .frame(minWidth: 800, minHeight: 600)
                .environmentObject(globaldata)
            
        }
        
        .commands {
               CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                   Button(action: {
                       appDelegate.showAboutPanel()
                   }) {
                       Text("SXMac rich editor")
                   }
                   
                  
               }
            
               
           }
        
        
           .windowStyle(HiddenTitleBarWindowStyle())
           
        .windowStyle(HiddenTitleBarWindowStyle()) // Убираем стандартный заголовок окна
      
        
    }
    
        
}
   
