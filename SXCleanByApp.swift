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

//global class

class GlobalDataModel : ObservableObject {
    
    @Published var allDefaultPaths: [String] = []
    
    
}

@main
struct SXCleanByApp: App {
    
    @StateObject private var globaldata = GlobalDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView() // Убедитесь, что ContentView существует
                .frame(minWidth: 800, minHeight: 600)
                .environmentObject(globaldata)
        }
        .windowStyle(HiddenTitleBarWindowStyle()) // Убираем стандартный заголовок окна
    }
}
