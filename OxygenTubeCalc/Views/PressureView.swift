//
//  PressureView.swift
//  OxygenTubeCalc
//
//  Created by Christian Schinkel on 2024-09-22.
//

import SwiftUI

struct PressureView: View {
    @Binding var pressure: Double
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            Slider(
                value: $pressure,
                in: 0...150,
                step: 10
            ) {
                Text("Pressure")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("150")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            
            Text("\(pressure, format: .number)")
                .foregroundColor(isEditing ? .red : .blue)
        }
        
    }
}

#Preview {
    struct Preview: View {
        @State var pressure: Double = 10
        
        var body: some View {
            PressureView(pressure: $pressure)
        }
    }
    
    return Preview()
}
