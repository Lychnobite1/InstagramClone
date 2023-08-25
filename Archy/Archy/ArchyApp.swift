//
//  ArchyApp.swift
//  Archy
//
//  Created by MURAT BAŞER on 20.08.2023.
//

import SwiftUI
import Firebase
@main
struct ArchyApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            
            if Auth.auth().currentUser != nil {
                MainView()
            }
            else {
                ContentView()
            }
            
        }
    }
}
