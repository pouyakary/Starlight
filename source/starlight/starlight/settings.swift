
//
//  Copyright © 2018-present by Pouya Kary <kary.us>, All rights reserved.
//

//
// ─── IMPORTS ────────────────────────────────────────────────────────────────────
//

    import Foundation

//
// ─── TYPINGS ────────────────────────────────────────────────────────────────────
//

    struct Settings: Codable {
        var minimumLux: Int?
        var intervals: Int?
        var sunrise: String?
        var sunset: String?
        var wallpapers: DarkLightPaths?
        var vscode: DarkLightPaths?
    }

    struct DarkLightPaths: Codable {
        var dark: String
        var light: String
    }


//
// ─── GENERATE BASE SETTINGS ─────────────────────────────────────────────────────
//

    func generateFactorySettings ( ) -> Settings {
        return Settings( minimumLux:    75000
                       , intervals:     10
                       , sunrise:       "06:00"
                       , sunset:        "18:00"
                       , wallpapers:    nil
                       , vscode:        nil
                       )
    }

//
// ─── APPEND FACTORY SETTINGS ────────────────────────────────────────────────────
//

    func appendFactorySettingsToEmptySettings ( baseSettings: Settings ) -> Settings {
        var settings = baseSettings
        let factorySettings = generateFactorySettings()

        func testDateFormat ( _ date: String ) -> Bool {
            return "\\d\\d:\\d\\d" =~ date
        }
    
    
        // tests and replacements
        if settings.minimumLux == nil {
            settings.minimumLux = factorySettings.minimumLux
        }
        
        if settings.intervals == nil {
            settings.intervals = factorySettings.intervals
        }
        
        if !( settings.sunrise != nil && testDateFormat( settings.sunrise! ) ) {
            settings.sunrise = factorySettings.sunrise
        }
        
        if !( settings.sunset != nil && !testDateFormat( settings.sunset! ) ) {
            settings.sunset = factorySettings.sunset
        }

        
        // done
        return settings
    }

//
// ─── LOAD SETTINGS ──────────────────────────────────────────────────────────────
//

    func loadSettings ( ) -> Settings {
        var settings: Settings

        do {
            let jsonFileString = try loadSettingsFileString( )
            print( " •• File loaded successfully" )
            try settings = decodeSettings( settingsJSON: jsonFileString )
            print( " •• File decoded successfully" )
            
            
        } catch {
            print( " •• Could not load settings file (~/.starlight.json).\n    Initializing with the factory presets." )
            settings = generateFactorySettings()
        }
        
        // done
        return settings
    }

//
// ─── DECODE SETTINGS ────────────────────────────────────────────────────────────
//

    func decodeSettings ( settingsJSON: String ) throws -> Settings {
        let decoder = JSONDecoder( )
        let jsonData = settingsJSON.data( using: .utf8 )!
        let settings = try decoder.decode( Settings.self, from: jsonData )
        return settings
    }

//
// ─── LOADING SETTINGS FILE CONTENTS ─────────────────────────────────────────────
//

    func loadSettingsFileString ( ) throws -> String {
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
        let starlightFileURL = homeDirURL.appendingPathComponent( ".starlight.json" )
        let contents = try String( contentsOf: starlightFileURL, encoding: .utf8 )
        return contents
    }

// ────────────────────────────────────────────────────────────────────────────────
