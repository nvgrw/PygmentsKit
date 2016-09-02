//
//  AppDelegate.swift
//  PygmentsKitTool
//
//  Created by Nik on 01/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Foundation
import PygmentsKit

let data = NSDictionary(contentsOfFile: "/Users/nik/Desktop/Tomorrow-Night.plist")! as [NSObject: AnyObject]
guard let theme = Theme(data: data) else {
    print("Can't load theme")
    exit(1)
}

do {
    try AttributedParser.parse("def __main__(self):\n    print(\"Hello World\")\n    a = 1 + 2\n\n__main__(None)", with: "python3", theme: theme) { (range, _, attributes) in
        print("Range:", NSStringFromRange(range), "Attributes", attributes)
    }
} catch let error {
    print("Error:", error)
}
