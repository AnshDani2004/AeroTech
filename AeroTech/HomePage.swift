//
//  HomePage.swift
//  AeroTech
//
//  Created by Ansh on 16/11/24.
//
import SwiftUI

struct FlightHoursAdvancedView: View {
    @State private var flightHours: Double = 50.0 // Example initial value
    @State private var selectedTab: String = "Current Status" // Default selected tab

    // Function to determine the color based on flight hours
    private func colorForFlightHours(_ hours: Double) -> Color {
        let percentage = hours / 100.0 // Normalize to 0–1
        return Color(
            red: 1.0 - percentage,
            green: percentage,
            blue: 0.0
        )
    }

    // Function to determine the attention message based on flight hours
    private func attentionMessage(for hours: Double) -> (String, Color) {
        switch hours {
        case 0..<15:
            return ("Immediate Attention Required", Color.red)
        case 15..<30:
            return ("Attention Required", Color.orange)
        case 30..<50:
            return ("Immediate Attention Not Required", Color.yellow)
        case 50...100:
            return ("No Attention Required", Color.green)
        default:
            return ("No Attention Required", Color.green)
        }
    }

    // Function to determine potential risks
    private func potentialRisks(for hours: Double) -> String {
        switch hours {
        case 0..<15:
            return "Critical: High risk of system failure."
        case 15..<30:
            return "Moderate: System integrity tampered."
        case 30..<50:
            return "Low: Minor wear and tear."
        case 50...100:
            return "None: System operating normally."
        default:
            return "Unknown status."
        }
    }

    // Function to determine potential solutions
    private func potentialSolutions(for hours: Double) -> String {
        switch hours {
        case 0..<15:
            return "Perform immediate maintenance."
        case 15..<30:
            return "Schedule a check soon."
        case 30..<50:
            return "Monitor regularly + routine checks."
        case 50...100:
            return "No action needed at this time."
        default:
            return "No solution available."
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Flight Hours Monitoring")
                .font(.title2)
                .fontWeight(.bold)

            HStack(spacing: 20) {
                // Output Section (on the left)
                VStack(alignment: .leading, spacing: 10) {
                    if selectedTab == "Current Status" {
                        let (message, color) = attentionMessage(for: flightHours)
                        Text("Current Status:")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(message)
                            .font(.body)
                            .foregroundColor(color)
                            .multilineTextAlignment(.leading)
                    } else if selectedTab == "Potential Risks" {
                        Text("Potential Risks:")
                            .font(.headline)
                            .foregroundColor(.red)
                        Text(potentialRisks(for: flightHours))
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    } else if selectedTab == "Potential Solutions" {
                        Text("Potential Solutions:")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(potentialSolutions(for: flightHours))
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(width: 160, alignment: .leading) // Adjusted width for text wrapping

                // Speedometer Section (on the right)
                ZStack {
                    // Outer Circle for Speedometer Background
                    Circle()
                        .stroke(lineWidth: 15)
                        .foregroundColor(Color.gray.opacity(0.2))

                    // Progress Arc
                    Circle()
                        .trim(from: 0.0, to: CGFloat(flightHours / 100))
                        .stroke(
                            colorForFlightHours(flightHours),
                            style: StrokeStyle(lineWidth: 15, lineCap: .round)
                        )
                        .rotationEffect(.degrees(180))
                        .animation(.easeInOut(duration: 0.5), value: flightHours)

                    // Center Text
                    Text("\(Int(flightHours))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(colorForFlightHours(flightHours))
                }
                .frame(width: 200, height: 200)
            }

            // Tabs for navigation (stacked vertically)
            VStack(spacing: 10) {
                Button(action: {
                    selectedTab = "Current Status"
                }) {
                    Text("Current Status")
                        .fontWeight(selectedTab == "Current Status" ? .bold : .regular)
                        .foregroundColor(selectedTab == "Current Status" ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedTab == "Current Status" ? Color.blue.opacity(0.1) : Color.clear
                        )
                        .cornerRadius(5)
                }

                Button(action: {
                    selectedTab = "Potential Risks"
                }) {
                    Text("Potential Risks")
                        .fontWeight(selectedTab == "Potential Risks" ? .bold : .regular)
                        .foregroundColor(selectedTab == "Potential Risks" ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedTab == "Potential Risks" ? Color.blue.opacity(0.1) : Color.clear
                        )
                        .cornerRadius(5)
                }

                Button(action: {
                    selectedTab = "Potential Solutions"
                }) {
                    Text("Potential Solutions")
                        .fontWeight(selectedTab == "Potential Solutions" ? .bold : .regular)
                        .foregroundColor(selectedTab == "Potential Solutions" ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedTab == "Potential Solutions" ? Color.blue.opacity(0.1) : Color.clear
                        )
                        .cornerRadius(5)
                }
            }
            .frame(maxWidth: .infinity) // Make buttons stretch horizontally

            // Slider to simulate changes
            Slider(value: $flightHours, in: 0...100, step: 1)
                .padding(.horizontal)
                .accentColor(.blue)

            Text("Adjust the slider to simulate hours")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}





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
                
                // Flight Hours Monitoring Section
                VStack {
                    Text("Flight Hours Advanced Monitoring")
                        .font(.headline)
                        .padding(.top)
                    FlightHoursAdvancedView()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
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

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
