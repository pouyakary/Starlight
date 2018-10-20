
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation
    import CoreLocation

//
// ─── COMPUTE STATUS ─────────────────────────────────────────────────────────────
//

    func computeStatus ( settings: Settings ) -> Bool {
        if checkSunriseSunset( settings: settings ) {
            return true
        }
        
        if checkAmbientLight( settings: settings ) {
            return true
        }

        return false
    }

//
// ─── AMBIENT LIGHT SENSOR ───────────────────────────────────────────────────────
//

    func checkAmbientLight ( settings: Settings ) -> Bool {
        return getAmbientLightInLux( ) < settings.minimumLux!
    }

//
// ─── SUNRISE AND SUNSET RULE CHECKERS ───────────────────────────────────────────
//

    func checkSunriseSunset ( settings: Settings ) -> Bool {
        if ( settings.sunset == nil || settings.sunrise == nil ) {
            return false
        }
        
        func hour ( _ date: Date ) -> String {
            let hourFarmatter = DateFormatter( )
            hourFarmatter.dateFormat = "HH:mm"
            return hourFarmatter.string(from: date)
        }

        let now     = Date.init()
        let sunrise = stringToDate( settings.sunrise!, settings: settings, isSunrise: true )!
        let sunset  = stringToDate( settings.sunset!, settings: settings, isSunrise: false )!
        
        let condition = ( now > sunset ) || ( now < sunrise )
        
        print( " • Rule of sunset to sunrise is: \(condition ? "on" : "off" ). Sunrise: \( hour( sunrise ) ), Sunset: \( ( hour( sunset ) ) )" )
        
        return condition
    }


    func stringToDate ( _ stringDate: String, settings: Settings, isSunrise: Bool ) -> Date? {    
        if stringDate == "auto" {
            let location = CLLocationCoordinate2D(latitude: settings.location!.latitude, longitude: settings.location!.longitude)
            let solar = Solar(coordinate: location)!
            return isSunrise ? solar.sunrise : solar.sunset
        }
        
        let dateFormatter =
            DateFormatter( )
        dateFormatter.dateFormat =
            "yyyy/MM/dd,HH:mm"
        let getTodaysFormattedDateOfToday =
            DateFormatter( )
        getTodaysFormattedDateOfToday.dateFormat =
            "yyyy/MM/dd"
        let todaysStringDate =
            getTodaysFormattedDateOfToday.string(from: Date())
        let template =
            todaysStringDate + "," + stringDate
        
        return dateFormatter.date( from: template ) ?? Date( )
    }

// ────────────────────────────────────────────────────────────────────────────────
