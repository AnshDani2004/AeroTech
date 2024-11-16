//
//  ChatbotPage.swift
//  AeroTech
//
//  Created by Ansh on 16/11/24.
//
import SwiftUI
import Foundation // Import Foundation for networking and API calls

struct ChatbotPage: View {
    @State private var userMessage: String = "" // To store the user's input
    @State private var chatMessages: [String] = [
        "Chatbot: Hello! How can I assist you today?" // Initial chatbot message
    ]
    
    // Replace with your Google Generative AI API key
    private let apiKey = "AIzaSyDTibW-YilUS-Z-EJX5GTGq40WTeWXARNI"

    var body: some View {
        NavigationView {
            VStack {
                // Chat Messages
                ScrollView {
                    ForEach(chatMessages, id: \.self) { message in
                        HStack {
                            if message.starts(with: "Chatbot") {
                                Text(message)
                                    .padding()
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text(message)
                                    .padding()
                                    .background(Color.blue.opacity(0.3))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Input Field and Send Button
                HStack {
                    TextField("Type a message...", text: $userMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: 30)

                    Button(action: {
                        sendMessage()
                    }) {
                        Text("Send")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Chatbot", displayMode: .inline)
        }
    }

    // Function to send message and get AI response
    private func sendMessage() {
        guard !userMessage.isEmpty else { return }
        
        // Add user message to chat
        chatMessages.append("You: \(userMessage)")

        // Make the API call to get AI response
        fetchAIResponse(for: userMessage) { response in
            DispatchQueue.main.async {
                if let response = response {
                    chatMessages.append("Chatbot: \(response)")
                } else {
                    chatMessages.append("Chatbot: Sorry, I couldn't process your request.")
                }
            }
        }
        
        // Clear the input field
        userMessage = ""
    }

    // Function to fetch AI response from Google Generative AI API
    private func fetchAIResponse(for prompt: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta2/text:generate?key=\(apiKey)")!
        
        // Request body
        let requestBody: [String: Any] = [
            "prompt": ["text": prompt],
            "temperature": 0.7,
            "candidateCount": 1
        ]
        
        // Create URL request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to serialize request body: \(error)")
            completion(nil)
            return
        }
        
        // Make the API call
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making API request: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned from API")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let candidates = json["candidates"] as? [[String: Any]],
                   let text = candidates.first?["output"] as? String {
                    completion(text)
                } else {
                    print("Unexpected response format")
                    completion(nil)
                }
            } catch {
                print("Failed to parse JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
