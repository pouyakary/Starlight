
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
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { setMacOSApperanceDarkModeTo( status: status ) }
        queue.async { changeMacOSWallpaper( status: status, settings: settings) }
        queue.async { setVisualStudioCodeThemeSettings( status: status, settings: settings ) }
    }

//
// ─── SET MAC OS WALLPAPERS ──────────────────────────────────────────────────────
//

    func changeMacOSWallpaper ( status: Bool, settings: Settings ) {
        if let wallpapers = settings.wallpapers {
            let wallpaperPath =
                ( status ? wallpapers.dark : wallpapers.light )

            runAppleScriptSourceCode("""
                tell application "System Events"
                    tell every desktop
                        set picture to "\( wallpaperPath )"
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
                    set dark mode to \( status )
                end tell
            end tell
        """)
    }

//
// ─── SET VISUAL STUDIO CODE THEME SETTINGS ──────────────────────────────────────
//

    func setVisualStudioCodeThemeSettings ( status: Bool, settings: Settings ) {
        if settings.vscode == nil || settings.vscode?.light == nil || settings.vscode?.dark == nil {
            return
        }

        do {
            let homeDirectory =
                FileManager.default.homeDirectoryForCurrentUser
            let vscodeSettingsURL =
                homeDirectory.appendingPathComponent(
                    "Library/Application Support/Code/User/settings.json" )
            let vscodeSettingsString =
                try String(contentsOf: vscodeSettingsURL, encoding: .utf8)
            let themeName =
                ( status ? settings.vscode!.dark : settings.vscode!.light )
                .replacingOccurrences(of: "\"", with: "\\\"", options: .literal, range: nil)
            let pattern =
                "\"workbench\\.colorTheme\"(?:\\s)*\\:(?:\\s)*\"(?:(?:\\\\\"|[^\"]))*\""
            let regex =
                try! NSRegularExpression(pattern: pattern,
                                         options: [])
            let range =
                NSMakeRange(0, vscodeSettingsString.count)
            let modifiedSettings =
                regex.stringByReplacingMatches(in: vscodeSettingsString,
                                          options: [],
                                            range: range,
                                     withTemplate: "\"workbench.colorTheme\": \"\( themeName )\"")
            try modifiedSettings.write(to: vscodeSettingsURL,
                               atomically: false,
                                 encoding: .utf8)

        } catch let error {
            print( " ✕ Failed to change the theme of Visual Studio Code" )
            print( error.localizedDescription )
        }
    }

// ────────────────────────────────────────────────────────────────────────────────
