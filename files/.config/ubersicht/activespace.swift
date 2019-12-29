import AppKit

setbuf(__stdoutp, nil)

// This is needed otherwise the activeSpaceDidChangeNotification never is
// received
let _ = NSWindow()
let conn = _CGSDefaultConnection()
let a = NSWorkspace.shared.notificationCenter.addObserver(
    forName: NSWorkspace.activeSpaceDidChangeNotification,
    object: nil,
    queue: nil,
    using: { _ in
        let info = CGSCopyManagedDisplaySpaces(conn) as! [NSDictionary]
        let displayInfo = info[0]
        let activeSpaceID = (displayInfo["Current Space"]! as! NSDictionary)["ManagedSpaceID"] as! Int
        let spaces = displayInfo["Spaces"] as! NSArray
        for (index, space) in spaces.enumerated() {
            let spaceID = (space as! NSDictionary)["ManagedSpaceID"] as! Int
            if spaceID == activeSpaceID {
                print(index + 1)
            }
        }
    }
)

RunLoop.current.run()
