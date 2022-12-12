import Foundation

/* OxygenTubeCalc */
/*
 Calculate the volume of oxygen-tube:
 
 Flaschenvålumen in [l] * actuall pressure on Manometer [bar]
 = Vorrat [l] (bei normal atmosfärical pressure von 1 bar
 
 example: 50 liter * 150 bar  = 7_500 liter (* 1 bar).
 
 */
//var liters = UnitVolume.liters
//var oxyTubeVolume: Double
//var oxyTubePressure: Double




func oxygenTubeVolumeStandardAtmosphere(tubeVolumeInLiter volume: Measurement<UnitVolume>, tubePressureInBars pressure: Measurement<UnitPressure>) -> Measurement<UnitVolume> {
    let tubeVolume = volume.value * pressure.value
    
    return Measurement(value: tubeVolume, unit: UnitVolume.liters)
}

oxygenTubeVolumeStandardAtmosphere(tubeVolumeInLiter: Measurement(value: 50, unit: UnitVolume.liters), tubePressureInBars: Measurement(value: 150, unit: UnitPressure.bars))

/** Calc formel for Oxygen-tub vorrat in minutes*/
/* (Flaschenvolumen [l] * angezeigtem druck auf dem manometer [bar]) / oxigenverbrauc [liter/min] * 1 bar
 = Zeit in minutes.
 
 example: (10 liter * 90 bar) / 2 liter/min * 1 bar = 450 minutes.
 */
func oxygenTubeRemindingTimeUntilEmpty(tubeVolume volume: Double, tubePressure pressure: Double, literPerMinute flow: Double) -> Double {
    return volume * pressure / flow
}

/*
 /* example for messurement by length */
let length = Measurement(value: 120.0, unit: UnitLength.kilometers)
length.converted(to: UnitLength.miles)

let kiloMeters = Measurement(value: 10.0, unit: UnitLength.kilometers)
let miles = Measurement(value: 10.0, unit: UnitLength.miles)

let result = kiloMeters + miles
result.formatted() // 16 mi

let formatStyle = Measurement<UnitLength>.FormatStyle(
    width: .wide,
    usage: .general,
    numberFormatStyle: .number
)

result.formatted(formatStyle)

 */
