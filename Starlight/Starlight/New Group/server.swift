
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

    class StarlightServer: NSObject {
        private var queue: DispatchQueue
        
        override init ( ) {
            self.queue = DispatchQueue.global(qos: .userInitiated)
        }
    
        public func start ( ) {
            self.queue = DispatchQueue.global(qos: .userInitiated)
            self.queue.async { serverLoop( ) }
        }
        
        public func stop ( ) {
            self.queue.suspend( )
        }
    }

//
// ─── SERVER LOOP ────────────────────────────────────────────────────────────────
//

    func serverLoop ( ) {
        while ( true ) {
            print( )

            let settings = loadSettings( )
            let status = computeStatus( settings: settings )

            setDarkModeTo( status: status, settings: settings )
            sleep( settings.intervals! )
        }
    }

// ────────────────────────────────────────────────────────────────────────────────
