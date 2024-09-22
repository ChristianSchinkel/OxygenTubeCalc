//
//  VolumeView.swift
//  OxygenTubeCalc
//
//  Created by Christian Schinkel on 2024-09-22.
//

import SwiftUI

struct VolumeView: View {
    @Binding var volume: Double
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            Slider(
                value: $volume,
                in: 0...50,
                step: 1
            ) {
                Text("Volume")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("50")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            Text("\(volume, format: .number)")
                .foregroundColor(isEditing ? .red : .blue)
        }
    }
}

#Preview {
    struct Preview: View {
        @State var volume: Double = 10
        
        var body: some View {
            VolumeView(volume: $volume)
        }
    }
    
    return Preview()
}
