//
//  NSColor+Extensions.swift
//  PygmentsKit
//
//  Created by Nik on 01/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Foundation
import AppKit.NSColor

extension NSColor {
    private static func getGroupValue(string: String, range: Range<Int>) -> CGFloat {
        let group = string.substring(with: string.index(string.startIndex, offsetBy: range.lowerBound)..<string.index(string.startIndex, offsetBy: range.upperBound))
        
        guard group.characters.count == 2,
            let intVal = Int(group, radix: 16) else {
                return 1.0
        }
        
        return CGFloat(Double(intVal)/255.0)
    }
    
    convenience init?(fromHex string: String) {
        var stringValue: String = {
            if string.characters.first == "#" {
                return string.substring(from: string.index(after: string.startIndex))
            }
            
            return string
        }()
        
        switch stringValue.characters.count {
        case 3: // RGB
            let r = String(stringValue[stringValue.index(stringValue.startIndex, offsetBy: 0)])
            let g = String(stringValue[stringValue.index(stringValue.startIndex, offsetBy: 1)])
            let b = String(stringValue[stringValue.index(stringValue.startIndex, offsetBy: 2)])
            stringValue = r + r + g + g + b + b + "FF"
        case 4: // RGBA
            let r = String(stringValue[stringValue.index(stringValue.startIndex, offsetBy: 0)])
            let g = String(stringValue[stringValue.index(stringValue.startIndex, offsetBy: 1)])
            let b = String(stringValue[stringValue.index(stringValue.startIndex, offsetBy: 2)])
            let a = String(stringValue[stringValue.index(stringValue.startIndex, offsetBy: 3)])
            stringValue = r + r + g + g + b + b + a + a
        case 6: // RRGGBB
            stringValue += "FF"
        case 8: // RRGGBBAA
            break
        default:
            return nil
        }
        
        stringValue = stringValue.lowercased()
        
        // We now have a string of 4 groups corresponding to RGBA
        
        let red = NSColor.getGroupValue(string: stringValue, range: 0..<2)
        let green = NSColor.getGroupValue(string: stringValue, range: 2..<4)
        let blue = NSColor.getGroupValue(string: stringValue, range: 4..<6)
        let alpha = NSColor.getGroupValue(string: stringValue, range: 6..<8)
        
        self.init(srgbRed: red, green: green, blue: blue, alpha: alpha)
    }
}
