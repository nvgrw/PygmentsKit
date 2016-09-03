//
//  ViewController.swift
//  PygmentsKitTool
//
//  Created by Nik on 02/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Cocoa
import PygmentsKit

class ViewController: NSViewController {

    @IBOutlet weak var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let themeData = NSDictionary(contentsOf: Bundle.main.url(forResource: "Twilight", withExtension: "tmTheme")!) as! [NSObject: AnyObject]
        let theme = Theme(data: themeData)!
        
        textView.backgroundColor = theme.global[.background]!
        textView.textColor = theme.global[.foreground]
        
        let string = try! String(contentsOf: Bundle.main.url(forResource: "test.swift", withExtension: "txt")!)
        
        textView.string = string
        
        try! AttributedParser.parse(textView.textStorage!.string, with: "swift", theme: theme) { (range, _, attributes) in
            self.textView.textStorage!.addAttributes(attributes, range: range)
        }
    }

}

