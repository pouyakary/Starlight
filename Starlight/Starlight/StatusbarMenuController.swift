import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var StarlightMenu: NSMenu!
    @IBOutlet weak var AboutView: NSView!
    var aboutViewItem: NSMenuItem!
    

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        let icon = NSImage(named: "statusbarIcon")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = StarlightMenu
        
        aboutViewItem = StarlightMenu.item(withTitle: "AboutView")
        aboutViewItem.view = AboutView
    }

    @IBAction func onQuitButton(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
