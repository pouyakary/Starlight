
import Foundation

enum Mode : String {
    case Automatic = "Automatic", Light = "Light", Dark = "Dark"
}

class ClientSettings {
    
    private let ModeKey          = "ModeKey"
    private let LaunchAtLoginKey = "LaunchAtLoginKey"
    private let defaults         = UserDefaults.standard
    
    init ( ) {
        if defaults.value( forKey: ModeKey ) == nil {
            defaults.set( "Automatic", forKey: ModeKey )
        }
        if defaults.value( forKey: LaunchAtLoginKey ) == nil {
            defaults.set( true, forKey: LaunchAtLoginKey )
        }
    }
    
    var mode: Mode {
        get {
            return Mode.init( rawValue: defaults.value( forKey: ModeKey )! as! String ) ?? Mode.Automatic
        }
        set ( value ) {
            defaults.set( value.rawValue, forKey: ModeKey )
        }
    }
    
    var launchAtLogin: Bool {
        get {
            return defaults.value( forKey: LaunchAtLoginKey )! as! Bool
        }
        set ( value ) {
            defaults.set( value, forKey: LaunchAtLoginKey )
        }
    }
}
