
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
        
        if ( getAmbientLightInLux( ) < settings.minimumLux! ) {
            status = true
        }
        
        return status
    }

// ────────────────────────────────────────────────────────────────────────────────
