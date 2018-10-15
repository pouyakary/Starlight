
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation

//
// ─── DEVICE APPEARANCE BASED ON LUX ─────────────────────────────────────────────
//

    func setDeviceAppearanceBasedOnLuxValue ( settings: Settings ) {
        let ambientLight = getAmbientLightInLux( )
        print(" • Ambient Light measured to be \(ambientLight) lx.")
        
        if ( ambientLight > settings.minimumLux! ) {
            setDarkModeTo( status: false, settings: settings )
        } else {
            setDarkModeTo( status: true, settings: settings )
        }
    }

//
// ─── MAIN ───────────────────────────────────────────────────────────────────────
//

    main( ); func main ( ) {
        print(" Starlight ✤ – Copyright 2018-present, Pouya Kary. All rights reserved\n")

        let settings = loadSettings( )
        
        print()

        while ( true ) {
            setDeviceAppearanceBasedOnLuxValue( settings: settings )
            sleep( 10 )
        }
    }


// ────────────────────────────────────────────────────────────────────────────────
