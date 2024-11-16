//
//  HomePage.swift
//  AeroTech
//
//  Created by Ansh on 16/11/24.
//
import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Navigation Bar
                HStack {
                    Button(action: {
                        // Action for Menu
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                    }
                    Spacer()
                    Text("App Name")
                        .font(.headline)
                    Spacer()
                }
                .padding()
                
                // Live Image Section
                VStack {
                    Image("jet_engine") // Replace with your image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .border(Color.yellow, width: 4)
                        .cornerRadius(10)
                    Text("Live images")
                        .font(.subheadline)
                        .padding(.top, 5)
                }
                
                // Status Fields
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Current Status")
                        Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pink.opacity(0.3))
                            .frame(width: 200, height: 30)
                    }
                    HStack {
                        Text("Potential Risks")
                        Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pink.opacity(0.3))
                            .frame(width: 200, height: 30)
                    }
                    HStack {
                        Text("Solutions")
                        Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pink.opacity(0.3))
                            .frame(width: 200, height: 30)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
