
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

            let settings = loadSettings( )
            let status = computeStatus( settings: settings )

            setDarkModeTo( status: status, settings: settings )
            sleep( settings.intervals! )
        }
    }


// ────────────────────────────────────────────────────────────────────────────────
