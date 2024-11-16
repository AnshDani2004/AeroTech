//
//  ViewHistoryPage.swift
//  AeroTech
//
//  Created by Ansh on 16/11/24.
//

import SwiftUI

struct ViewHistoryPage: View {
    @State private var inspections: [String] = [
        "Inspection 1: Engine OK - Low Risk",
        "Inspection 2: Engine Maintenance Required - Medium Risk",
        "Inspection 3: Engine Fault - High Risk"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List(inspections, id: \.self) { inspection in
                    Text(inspection)
                }
                .navigationBarTitle("View History", displayMode: .inline)
            }
        }
    }
}
