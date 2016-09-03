//
//  TestsSupport.swift
//  PygmentsKit
//
//  Created by Nik on 02/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Foundation
@testable import PygmentsKit

let testBundle = Bundle(for: ThemeTests.self)

let theme: Theme = {
    let themeData = NSDictionary(contentsOf: testBundle.url(forResource: "Twilight", withExtension: "tmTheme")!) as! [NSObject: AnyObject]
    return Theme(data: themeData)!
}()

let sourceSwift = try! String(contentsOf: testBundle.url(forResource: "test.swift", withExtension: "txt")!)
let sourceRuby = try! String(contentsOf: testBundle.url(forResource: "test.rb", withExtension: "txt")!)
let sourceJava = try! String(contentsOf: testBundle.url(forResource: "test.java", withExtension: "txt")!)
let sourceD = try! String(contentsOf: testBundle.url(forResource: "test.d", withExtension: "txt")!)
let sourceCpp = try! String(contentsOf: testBundle.url(forResource: "test.cpp", withExtension: "txt")!)
