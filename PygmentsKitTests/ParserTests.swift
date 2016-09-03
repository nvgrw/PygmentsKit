//
//  ParserTests.swift
//  PygmentsKit
//
//  Created by Nik on 02/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
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

}
