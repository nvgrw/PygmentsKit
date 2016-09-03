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

