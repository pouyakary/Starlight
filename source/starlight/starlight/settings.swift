
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
        var intervals:  UInt32?
        
        var sunrise:    String?
        var sunset:     String?
        var location:   Coordinates?
        
        var wallpapers: DarkLightPaths?
        var vscode:     DarkLightPaths?
    }

    struct Coordinates: Codable {
        var latitude:    Double
        var longitude:   Double
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
                       , sunrise:       nil
                       , sunset:        nil
                       , location:      nil
                       , wallpapers:    nil
                       , vscode:        nil
                       )
    }

//
// ─── CHECK SETTINGS ─────────────────────────────────────────────────────────────
//

    func checkSettings ( baseSettings: Settings ) -> Settings {
        var settings =
            baseSettings
        let factorySettings =
            generateFactorySettings( )

        func testDateFormat ( _ date: String ) -> Bool {
            return date =~ "\\d\\d\\:\\d\\d"
        }
    
    
        // lux
        if settings.minimumLux == nil {
            settings.minimumLux = factorySettings.minimumLux
        }
        
        // intervals
        if settings.intervals == nil {
            settings.intervals = factorySettings.intervals
        }
        
        // sunset / sunrise
        if settings.sunrise != nil {
            if settings.sunrise == "auto" {
                if settings.location == nil {
                    settings.sunrise = nil
                }
            } else if !testDateFormat( settings.sunrise! ) {
                settings.sunrise = nil
            }
        }
        
        if settings.sunset != nil {
            if settings.sunset == "auto" {
                if settings.location == nil {
                    settings.sunset = nil
                }
            } else if !testDateFormat( settings.sunset! ) {
                settings.sunset = nil
            }
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
            let jsonFileString =
                try loadSettingsFileString( )

            print( " •• Settings loaded successfully" )

            try settings =
                decodeSettings( settingsJSON: jsonFileString )

            print( " •• Settings decoded successfully" )
            
            settings =
                checkSettings( baseSettings: settings )
            
            print( " •• Settings checked" )
            
            
        } catch {
            print( " •• Could not load settings file (~/.starlight.json).\n    Initializing with the factory presets." )
            print( error )
            settings =
                generateFactorySettings( )
        }
        
        // done
        return settings
    }

//
// ─── DECODE SETTINGS ────────────────────────────────────────────────────────────
//

    func decodeSettings ( settingsJSON: String ) throws -> Settings {
        let decoder =
            JSONDecoder( )
        let jsonData =
            settingsJSON.data( using: .utf8 )!
        let settings =
            try decoder.decode( Settings.self, from: jsonData )
        return settings
    }

//
// ─── LOADING SETTINGS FILE CONTENTS ─────────────────────────────────────────────
//

    func loadSettingsFileString ( ) throws -> String {
        let homeDirURL =
            FileManager.default.homeDirectoryForCurrentUser
        let starlightFileURL =
            homeDirURL.appendingPathComponent( ".starlight.json" )
        let contents =
            try String( contentsOf: starlightFileURL, encoding: .utf8 )
        return contents
    }

// ────────────────────────────────────────────────────────────────────────────────
