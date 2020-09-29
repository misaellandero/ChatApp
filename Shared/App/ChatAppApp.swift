//
//  ChatAppApp.swift
//  Shared
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI
import Firebase

@main
struct ChatAppApp: App {
     
    init() {
        FirebaseApp.configure()
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionStore())
                .environmentObject(DataStore())
        }
    }
}
