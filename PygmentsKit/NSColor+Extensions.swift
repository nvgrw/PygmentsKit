//
//  Copyright (c) 2016 Niklas Vangerow
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
