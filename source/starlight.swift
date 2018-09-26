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
                print("error: \(error)")
                exit( 1 )
            }
        }
        
        NSAppleScript(source: source)?.executeAndReturnError(nil)
    }

//
// ─── GET DEVICE AMBIENT LIGHT ───────────────────────────────────────────────────
//

    func getAmbientLightInLux() -> Int {
        guard let serviceType = IOServiceMatching("AppleLMUController") else {
            debugPrint("No ambient light sensor")
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
            debugPrint("Coult not read ambient light sensor (1)")
            return -1
        }
        
        setbuf(stdout, nil)
        
        var outputs: UInt32 = 2
        let values = UnsafeMutablePointer<UInt64>.allocate(capacity: Int(outputs))
        let zero: UnsafeMutablePointer<Int> = UnsafeMutablePointer<Int>.allocate(capacity: 8)
        
        guard IOConnectCallMethod(dataPort, 0, nil, 0, nil, 0, values, &outputs, nil, zero) == KERN_SUCCESS else {
            debugPrint("Could not read ambient light sensor (2)")
            return -1
        }
        
        return Int(values[0])
    }

//
// ─── SET DARK MODE ──────────────────────────────────────────────────────────────
//

    func setDarkModeTo( status: Bool ) {
        runAppleScriptSourceCode(
            "tell application \"System Events\"\n" +
                "tell appearance preferences\n" +
                    "set dark mode to \(status)\n" +
                "end tell\n" +
            "end tell"
        )
    }

//
// ─── DEVICE APPEARANCE BASED ON LUX ─────────────────────────────────────────────
//

    func setDeviceAppearanceBasedOnLuxValue ( ) {
        let ambientLight = getAmbientLightInLux()
        print(" • Ambient Light measured to be \(ambientLight) lx.")
        
        if ( ambientLight > 75000 ) {
            setDarkModeTo(status: false)
        } else {
            setDarkModeTo(status: true)
        }
    }

//
// ─── MAIN ───────────────────────────────────────────────────────────────────────
//

    print(" Autodark ✤ – Copyright 2018-present by Pouya Kary. All Rights reserved.")

    while ( true ) {
        setDeviceAppearanceBasedOnLuxValue( )
        sleep( 10 )
    }

// ────────────────────────────────────────────────────────────────────────────────
