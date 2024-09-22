//
//  FlowView.swift
//  OxygenTubeCalc
//
//  Created by Christian Schinkel on 2024-09-22.
//

import SwiftUI

struct FlowView: View {
    @Binding var flow: Double
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            Slider(
                value: $flow,
                in: 0...15,
                step: 1
            ) {
                Text("Flow")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("15")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            
            Text("\(flow, format: .number)")
                .foregroundColor(isEditing ? .red : .blue)
        }
    }
}

#Preview {
    struct Preview: View {
        @State var flow: Double = 2
        
        var body: some View {
            FlowView(flow: $flow)
        }
    }
    
    return Preview()
}
