
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation

//
// ─── SET DARK MODE ──────────────────────────────────────────────────────────────
//

    func setDarkModeTo( status: Bool, settings: Settings ) {
        setMacOSApperanceDarkModeTo( status: status )
        changeMacOSWallpaper( status: status, settings: settings)
    }

//
// ─── SET MAC OS WALLPAPERS ──────────────────────────────────────────────────────
//

    func changeMacOSWallpaper ( status: Bool, settings: Settings ) {
        if let wallpapers = settings.wallpapers {
            let wallpaperPath = (status ? wallpapers.dark : wallpapers.light)
            runAppleScriptSourceCode("""
                tell application "System Events"
                    tell every desktop
                        set picture to "\(wallpaperPath)"
                    end tell
                end tell
            """)
        }
    }

//
// ─── SET DARK MODE SYSTEM WIDE ──────────────────────────────────────────────────
//

    func setMacOSApperanceDarkModeTo( status: Bool ) {
        runAppleScriptSourceCode("""
            tell application "System Events"
                tell appearance preferences
                    set dark mode to \(status)
                end tell
            end tell
        """)
    }


// ────────────────────────────────────────────────────────────────────────────────
