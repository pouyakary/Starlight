
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation

//
// ─── MAIN ───────────────────────────────────────────────────────────────────────
//

    main( ); func main ( ) {
        print( " Starlight ✤ – Copyright 2018-present,"
             + " Pouya Kary. All rights reserved"
             )
        
        while ( true ) {
            print( )

            var sampleCounter = 0.0
            let settings = loadSettings( )
            let sleepTime =
                UInt32( Double(settings.intervals!) / Double(settings.samples!) )

            for _ in 1...(settings.samples!) {
                let status = computeStatus( settings: settings )
                if status {
                    sampleCounter += 1
                }
                sleep( sleepTime )
            }
            
            let average = sampleCounter / Double(settings.samples!)
            print( " ••• Average of \( settings.samples! ) samples evaluted to: \( average )." )

            setDarkModeTo( status: average >= 0.5, settings: settings )
        }
    }


// ────────────────────────────────────────────────────────────────────────────────
