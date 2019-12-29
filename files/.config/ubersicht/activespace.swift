//
//  main.swift
//  ActiveSpace
//
//  Created by Cam Spiers on 29/12/19.
//  Copyright © 2019 Cam Spiers. All rights reserved.
//

import Cocoa

let _ = NSWindow()
let conn = _CGSDefaultConnection()
let a = NSWorkspace.shared.notificationCenter.addObserver(
    forName: NSWorkspace.activeSpaceDidChangeNotification,
    object: nil,
    queue: nil,
    using: { (notification: Notification) in
        let info = CGSCopyManagedDisplaySpaces(conn) as! [NSDictionary]
        let displayInfo = info[0]
        let activeSpaceID = (displayInfo["Current Space"]! as! NSDictionary)["ManagedSpaceID"] as! Int
        let spaces = displayInfo["Spaces"] as! NSArray
        for (index, space) in spaces.enumerated() {
            let spaceID = (space as! NSDictionary)["ManagedSpaceID"] as! Int
            let spaceNumber = index + 1
            if spaceID == activeSpaceID {
                print(spaceNumber)
            }
        }
    }
)


RunLoop.current.run()
