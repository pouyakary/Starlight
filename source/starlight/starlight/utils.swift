
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation

//
// ─── RUN APPLE SCRIPT SOURCE CODE ───────────────────────────────────────────────
//

    func runAppleScriptSourceCode(_ source: String) {
        var error: NSDictionary?
        
        if let scriptObject = NSAppleScript(source: source) {
            scriptObject.executeAndReturnError( &error )
            
            if (error != nil) {
                print( " ••• Failed to execute apple script: \"\( source )\"" )
            }
        }
        
        NSAppleScript(source: source)?.executeAndReturnError(nil)
    }

//
// ─── GET DEVICE AMBIENT LIGHT ───────────────────────────────────────────────────
//

    func getAmbientLightInLux() -> Int {
        guard let serviceType = IOServiceMatching("AppleLMUController") else {
            debugPrint(" ••• No ambient light sensor")
            return -1
        }
        
        // get and release service
        let service = IOServiceGetMatchingService(kIOMasterPortDefault, serviceType)
        defer {
            IOObjectRelease(service)
        }
        
        // open io connection
        var dataPort: io_connect_t = 0
        guard IOServiceOpen(service, mach_task_self_, 0, &dataPort) == KERN_SUCCESS else {
            debugPrint(" ••• Coult not read ambient light sensor (1)")
            return -1
        }
        
        setbuf(stdout, nil)
        
        var outputs: UInt32 = 2
        let values = UnsafeMutablePointer<UInt64>.allocate(capacity: Int(outputs))
        let zero: UnsafeMutablePointer<Int> = UnsafeMutablePointer<Int>.allocate(capacity: 8)
        
        guard IOConnectCallMethod( dataPort, 0, nil, 0, nil, 0, values, &outputs, nil, zero ) == KERN_SUCCESS else {
            debugPrint( " ••• Could not read ambient light sensor (2)" )
            return -1
        }
        
        let result = Int( values[ 0 ] )
        
        print(" • Ambient Light measured to be \( result ) lx.")
        
        return result
    }

//
// ─── CLEAR SCREEn ───────────────────────────────────────────────────────────────
//

    func clearScreen ( ) {
        let clearScreen = Process()
        clearScreen.launchPath = "/usr/bin/clear"
        clearScreen.arguments = [ ]
        clearScreen.launch()
    }

// ────────────────────────────────────────────────────────────────────────────────
