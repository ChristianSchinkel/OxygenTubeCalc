//
//  ContentView.swift
//  OxygenTubeCalc
//
//  Created by Christian Schinkel on 2022-12-12.
//

import SwiftUI

struct ContentView: View {
    @State private var volume: Double = 10
    @State private var pressure: Double = 150
    @State private var flow: Double = 2
    
    private var gaugeTime: Double {
        remindingMinutes.value
    }
    
    private var currentVolume: Measurement<UnitVolume> {
        oxygenTubeVolumeStandardAtmosphere(tubeVolumeInLiter: volume, tubePressureInBars: pressure)
    }
    
    private var remindingMinutes: Measurement<UnitDuration> {
        oxygenTubeRemindingTimeUntilEmpty(tubeVolume: volume, tubePressure: pressure, literPerMinute: flow)
    }
    
    private var changeTubeDueDate: Date {
        calcChangingTimeWithMarginal(tubeVolume: volume, tubePressure: pressure, literPerMinute: flow)
    }
    
    let swedishVolumeFormatStyle = Measurement<UnitVolume>.FormatStyle(width: .wide, locale: .init(languageCode: .swedish, script: .latin, languageRegion: .sweden), usage: .liquid, numberFormatStyle: .number)
    let durationFormatStyle = Measurement<UnitDuration>.FormatStyle(width: .wide, usage: .general, numberFormatStyle: .number)
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Volume:") {
                    VolumeView(volume: $volume)
                    PressureView(pressure: $pressure)
                    Text("The current volume of the Tube is now: \(currentVolume.formatted(swedishVolumeFormatStyle)).")
                }
                
                Section("Reminding Time:") {
                    FlowView(flow: $flow)
                    
                    Gauge(value: gaugeTime, in: 0...750) {
                        Text("The current estimated time until the tube is empty is now: \n \(remindingMinutes.formatted(durationFormatStyle)).")
                    }
                }
            }
            .keyboardType(.decimalPad)
            .navigationTitle("OxygenTubeCalc")
            
            VStack(alignment: .leading) {
                Text("Change tube at:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(changeTubeDueDate, format: .dateTime)")
                    .font(.title)
                    .fontWeight(.semibold)
            }
        }
    }
    // MARK: - Functions for this View
    /// This method returns the volume (in liter|s [L]) of a tube filled with oxygen for medical usage at standard atmosphere (atm).
    /// - Parameters:
    ///   - volume: liter/s [L]
    ///   - pressure: bars [bar]
    /// - Returns: Volume of oxygen at atm in liter [L]
    private func oxygenTubeVolumeStandardAtmosphere(tubeVolumeInLiter volume: Double, tubePressureInBars pressure: Double) -> Measurement<UnitVolume> {
        
        let tubeVolume = volume * pressure
        
        return Measurement(value: tubeVolume, unit: UnitVolume.liters)
    }
    
    /// This method returns the approximately reminding time until a tube filled with oxygen for medical usage is empty (without any gas left in the tube) (BE AWERE ABOUT:  The author of this method *IS NOT TO BE CHARGED* to *ANY* harm that might be occur the use of this code. *ONLY* The qualified care-worker is responsible for it).
    /// - Parameters:
    ///   - volume: liter/s [L]
    ///   - pressure: bars [bar]
    ///   - flow: liter/s per minute [L/min]
    /// - Returns: An estimated time in minute/s until the oxygen-tube is empty.
    private func oxygenTubeRemindingTimeUntilEmpty(tubeVolume volume: Double, tubePressure pressure: Double, literPerMinute flow: Double) -> Measurement<UnitDuration> {
        let minutes = volume * pressure / flow
        
        return  Measurement(value: minutes, unit: UnitDuration.minutes)
    }
    /// This method returns a date when to change a tube filled with oxygen for medical usage with a marginal of 10 %.
    /// - Parameters:
    ///   - volume: liter/s [L]
    ///   - pressure: bars [bar]
    ///   - flow: liter/s per minute [L/min]
    /// - Returns: An estimated date when to change the oxygen-tube.
    private func calcChangingTimeWithMarginal(tubeVolume volume: Double, tubePressure pressure: Double, literPerMinute flow: Double) -> Date {
        let minutes = volume * pressure / flow
        let seconds = minutes * 60 * 0.9
        
        return Date().addingTimeInterval(seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
