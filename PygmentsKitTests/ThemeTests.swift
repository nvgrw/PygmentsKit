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

import XCTest
@testable import PygmentsKit

class ThemeTests: XCTestCase {
    
    func testWhereThemeDoesNotExist() {
        XCTAssertNil(Theme(data: [:]))
    }
    
    func testStandardScopeSelector() {
        let scope = theme.resolveScope(selector: "entity.other.inherited-class")
        XCTAssertNotNil(scope)
    }
    
    func testScopeSelectorThatIsTooDeep() {
        let scope = theme.resolveScope(selector: "entity.other.inherited-class.this.is.too.deep")
        let correctScope = theme.resolveScope(selector: "entity.other.inherited-class")
        
        XCTAssertEqual(scope, correctScope)
    }
    
    func testLateralScopeSelector() {
        let scope = theme.resolveScope(selector: "string meta.embedded")
        
        XCTAssertNotNil(scope)
    }
    
    func testHexColorParsing() {
        // Black colours
        let black = NSColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(black, NSColor(fromHex: "#000"))
        XCTAssertEqual(black, NSColor(fromHex: "#000F"))
        XCTAssertEqual(black, NSColor(fromHex: "#000000"))
        XCTAssertEqual(black, NSColor(fromHex: "#000000FF"))
        
        // Red colours
        let red = NSColor(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(red, NSColor(fromHex: "#F00"))
        XCTAssertEqual(red, NSColor(fromHex: "#F00F"))
        XCTAssertEqual(red, NSColor(fromHex: "#FF0000"))
        XCTAssertEqual(red, NSColor(fromHex: "#FF0000FF"))
        
        // Green colours
        let green = NSColor(srgbRed: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(green, NSColor(fromHex: "#0F0"))
        XCTAssertEqual(green, NSColor(fromHex: "#0F0F"))
        XCTAssertEqual(green, NSColor(fromHex: "#00FF00"))
        XCTAssertEqual(green, NSColor(fromHex: "#00FF00FF"))
        
        // Blue colours
        let blue = NSColor(srgbRed: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        XCTAssertEqual(blue, NSColor(fromHex: "#00F"))
        XCTAssertEqual(blue, NSColor(fromHex: "#00FF"))
        XCTAssertEqual(blue, NSColor(fromHex: "#0000FF"))
        XCTAssertEqual(blue, NSColor(fromHex: "#0000FFFF"))
    }
    
    func testThemeExistingGlobalSettings() {
        XCTAssertEqual(NSColor(fromHex: "#F8F8F8")!, theme.global[.foreground])
        
        XCTAssertEqual(NSColor(fromHex: "#181818")!, theme.global[.background])
        
        XCTAssertEqual(NSColor(fromHex: "#A7A7A7")!, theme.global[.caret])
        
        XCTAssertEqual(NSColor(fromHex: "#FFFFFF40")!, theme.global[.invisibles])
        
        XCTAssertEqual(NSColor(fromHex: "#FFFFFF08")!, theme.global[.lineHighlight])
        
        XCTAssertEqual(NSColor(fromHex: "#DDF0FF33")!, theme.global[.selection])
    }
    
    func testThemeNonexistingGlobalSettings() {
        XCTAssertNil(theme.global[.guide])
    }

}
