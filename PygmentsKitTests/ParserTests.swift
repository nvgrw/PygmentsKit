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

class ParserTests: XCTestCase {

    func testPygmentsAvailable() {
        // Check that there is a path to the pygments script
        XCTAssertNotNil(Parser.pygmentsScript)
        
        // Check that the file exists
        XCTAssertTrue(FileManager.default.fileExists(atPath: Parser.pygmentsScript!.path))
    }
    
    func testInvalidLexer() {
        do {
            try Parser.parse("", with: "NOTALEXER", callback: { (_, _) in })
            XCTAssertTrue(false)
        } catch let e as Parser.ParserError {
            if case Parser.ParserError.pygmentizeStderr(_) = e {
                XCTAssertTrue(true)
            } else {
                XCTAssertTrue(false)
            }
        } catch let e {
            XCTFail("Exception thrown: \(e)")
        }
    }
    
    func testParseSwift() {
        measure {
            try! Parser.parse(sourceSwift, with: "swift", callback: { (_, _) in })
        }
    }
    
    func testParseRuby() {
        measure {
            try! Parser.parse(sourceRuby, with: "ruby", callback: { (_, _) in })
        }
    }
    
    func testParseD() {
        measure {
            try! Parser.parse(sourceD, with: "d", callback: { (_, _) in })
        }
    }
    
    // These just take too long so I'm not using measure
    func testParseJava() throws {
        try Parser.parse(sourceJava, with: "java", callback: { (_, _) in })
    }
    
    func testParseCpp() throws {
        try Parser.parse(sourceCpp, with: "cpp", callback: { (_, _) in })
    }

    func testFindLexer() throws {
        let lexer = try Parser.findLexer(for: "file.swift")
        XCTAssertEqual(lexer, "swift")
        
        let lexer2 = try Parser.findLexer(for: "somefile")
        XCTAssertEqual(lexer2, "text")
        
        let lexer3 = try Parser.findLexer(for: "Hello.m")
        XCTAssertEqual(lexer3, "objective-c")
    }
}
