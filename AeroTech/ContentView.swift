//
//  ContentView.swift
//  AeroTech
//
//  Created by Ansh on 16/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePage() // Navigate to Home Page
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ViewHistoryPage() // Navigate to View History Page
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
            
            ChatbotPage() // Navigate to Chatbot Page
                .tabItem {
                    Label("Chatbot", systemImage: "message")
                }
        }
    }
}
