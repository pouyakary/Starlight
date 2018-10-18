import Cocoa

class StatusMenuController: NSObject {

    @IBOutlet weak var StarlightMenu: NSMenu!
    @IBOutlet weak var AboutView: NSView!
    @IBOutlet weak var AmbientLightLabel: NSTextField!
    
    @IBOutlet weak var AutomaticOptionItem: NSMenuItem!
    @IBOutlet weak var LightOptionItem: NSMenuItem!
    @IBOutlet weak var DarkOptionItem: NSMenuItem!
    
    @IBOutlet weak var LaunchAtLoginItem: NSMenuItem!

    var aboutViewItem:  NSMenuItem!
    var queue:          DispatchQueue
    let statusItem:     NSStatusItem
    var clientSettings: ClientSettings


    override init ( ) {
        self.clientSettings = ClientSettings( )
        self.queue = DispatchQueue.global(qos: .userInitiated)
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    }


    override func awakeFromNib() {
        let icon = NSImage(named: "statusbarIcon")
        icon?.isTemplate = true
        statusItem.button?.image = icon
        statusItem.menu = StarlightMenu
        
        aboutViewItem = StarlightMenu.item(withTitle: "AboutView")
        aboutViewItem.view = AboutView

        queue.async { self.updateAmbientLightLoop( ) }
        
        setMode( to: clientSettings.mode )
        setLaunchAtLoginMode()
    }
    
    
    func updateAmbientLightLoop ( ) {
        while true {
            let ambientLightLux = getAmbientLightInLux( )
            self.AmbientLightLabel.stringValue = "Ambient Light: \(ambientLightLux) lx"
            sleep( 5 )
        }
    }
    
    
    func setMode( to: Mode ) {
        self.clientSettings.mode = to
        AutomaticOptionItem.state = .off
        LightOptionItem.state   = .off
        DarkOptionItem.state    = .off
        
        switch self.clientSettings.mode {
            case .Automatic:
                AutomaticOptionItem.state = .on
                break
            case .Light:
                LightOptionItem.state = .on
                break
            
            case .Dark:
                DarkOptionItem.state = .on
                break
        }
    }
    
    
    func setLaunchAtLoginMode ( ) {
        LaunchAtLoginItem.state = self.clientSettings.launchAtLogin ? .on : .off
    }
    
    
    @IBAction func onQuitButton(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    
    @IBAction func onOpenWebsite(_ sender: Any) {
        let url = URL(string: "https://kary.us/projects/starlight")
        NSWorkspace.shared.open(url!)
    }
    
    
    @IBAction func onOpenConfigFile(_ sender: Any) {
        let homeDirURL =
            FileManager.default.homeDirectoryForCurrentUser
        let starlightFileURL = homeDirURL.appendingPathComponent( ".starlight.json" )
        NSWorkspace.shared.open(starlightFileURL)
    }
    
    
    @IBAction func onSetStateToAutomatic(_ sender: Any) {
        setMode(to: .Automatic)
    }
    
    @IBAction func onSetStateToLight(_ sender: Any) {
        setMode(to: .Light)
    }
    
    @IBAction func onSetStateToDark(_ sender: Any) {
        setMode(to: .Dark)
    }
    
    
    @IBAction func onLaunchAtLoginItemClicked(_ sender: Any) {
        self.clientSettings.launchAtLogin = !self.clientSettings.launchAtLogin
        setLaunchAtLoginMode( )
    }
    
}
