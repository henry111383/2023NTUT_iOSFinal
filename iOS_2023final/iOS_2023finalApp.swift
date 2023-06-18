//
//  iOS_2023finalApp.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/2.
//

import SwiftUI
import Firebase

@main
struct iOS_2023finalApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

