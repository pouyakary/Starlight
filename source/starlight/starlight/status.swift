
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation

//
// ─── COMPUTE STATUS ─────────────────────────────────────────────────────────────
//

    func computeStatus ( settings: Settings ) -> Bool {
        var status = false
        
        status = checkAmbientLight( status: status, settings: settings )
        status = checkSunriseSunset( status: status, settings: settings )
        
        return status
    }

//
// ─── AMBIENT LIGHT SENSOR ───────────────────────────────────────────────────────
//

    func checkAmbientLight ( status: Bool, settings: Settings ) -> Bool {
        return getAmbientLightInLux( ) < settings.minimumLux!
    }

//
// ─── SUNRISE AND SUNSET RULE CHECKERS ───────────────────────────────────────────
//

    func checkSunriseSunset ( status: Bool, settings: Settings ) -> Bool {
        if ( settings.sunset == nil || settings.sunrise == nil ) {
            return status
        }
        
        let now     = Date.init()
        let sunrise = stringToDate( settings.sunrise! )!
        let sunset  = stringToDate( settings.sunset!  )!
        
        let condition = ( now > sunset ) || ( now < sunrise )
        
        print( " • Rule of sunset to sunrise is: \(condition ? "on" : "off" )" )
        
        return condition
    }


    func stringToDate ( _ stringDate: String ) -> Date? {
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
