//
//  Parser.swift
//  PygmentsKit
//
//  Created by Nik on 01/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Foundation
import os

/// Parse a string and return the tokens and their associated range
public class Parser {
    
    private static let log = OSLog(subsystem: "uk.notro.PygmentsKit", category: "Parser")
    
    public typealias ParserCallback = (_ range: NSRange, _ token: Token) -> Void
    
    public enum ParserError: Error {
        case noPygmentizeScript
        case cantEncodeCodeString
        case pygmentizeStderr(String)
    }
    
    @available(*, unavailable)
    private init() { }
    
    /// Obtain tokens from pygments for the code and chosen lexer
    ///
    /// - parameter code:  Code string
    /// - parameter lexer: pygments lexer string
    ///
    /// - returns: Array of tokens
    static func tokenize(_ code: String, with lexer: String) throws -> [Token] {
        
        // Get the pygments script path
        let bundle = Bundle(for: Parser.self)
        guard let pygmentsScript = bundle.resourceURL?.appendingPathComponent("pygmentize") else {
            throw ParserError.noPygmentizeScript
        }
        
        guard let encodedCode = code.data(using: .utf8) else {
            throw ParserError.cantEncodeCodeString
        }
        
        os_log("Found pygmentize at %{public}s", log: Parser.log, type: .debug, pygmentsScript.path)
        
        // Set up the process
        let pyg = Process()
        pyg.launchPath = "/usr/bin/env"
        pyg.arguments = ["python", pygmentsScript.path, "-f", "raw", "-l", lexer]
        
        // Write the code to standard input
        let stdin = Pipe()
        stdin.fileHandleForWriting.write(encodedCode)
        stdin.fileHandleForWriting.closeFile()
        
        // Get standard output form
        let stdout = Pipe()
        let stderr = Pipe()
        
        // Set up the pipes
        pyg.standardInput = stdin
        pyg.standardOutput = stdout
        pyg.standardError = stderr
        
        // Launch pygmentize
        pyg.launch()
        pyg.waitUntilExit()
        
        guard pyg.terminationStatus == 0 else {
            // We encountered some kind of problem
            throw ParserError.pygmentizeStderr(String(data: stderr.fileHandleForReading.availableData, encoding: .utf8) ?? "")
        }
        
        guard let output = String(data: stdout.fileHandleForReading.availableData, encoding: .utf8) else {
            // No tokens generated
            return []
        }
        
        var tokens = [Token]()
        // TODO: Use enumerateLines instead
        for line in output.components(separatedBy: .newlines) {            
            let lineSplit = line.components(separatedBy: "\t")
            guard lineSplit.count == 2 else {
                // we are expecting two components
                continue
            }
            
            let kindStr = lineSplit[0]
            let payloadStr = lineSplit[1]
            
            guard let kind = Token.Kind(rawValue: kindStr) else {
                // Unknown token
                print("Unknown token kind \(kindStr)")
                continue
            }
            
            // all payload is preceded with u' and ends in '
            guard payloadStr.characters.count >= 2 && payloadStr.characters.count % 2 == 0 else {
                // We don't have enough characters in the payload, missing the unicode string.
                print("Not enough characters in payload \(payloadStr)")
                continue
            }
            
            
            let payloadSbstr = payloadStr.substring(with: payloadStr.index(after: payloadStr.startIndex)..<payloadStr.index(before: payloadStr.endIndex))
            var data = Data()
            var i = 0
            while i < payloadSbstr.characters.count {
                let chrs = "\(payloadSbstr[payloadSbstr.index(payloadSbstr.startIndex, offsetBy: i)])\(payloadSbstr.characters[payloadSbstr.index(payloadSbstr.startIndex, offsetBy: i + 1)])"
                let byte = UInt8(chrs, radix: 16)!
                data.append(byte)
                i += 2
            }
            
            guard let payload = String(data: data, encoding: .utf8) else {
                continue
            }
            
            tokens.append(Token(kind: kind, payload: payload))
        }
        
        
        return tokens
    }
    
    /// Parse a code string using a pygments lexer and obtain the tokens and their range.
    ///
    /// - parameter code:     Code to parse.
    /// - parameter lexer:    Lexer to tokenise with.
    /// - parameter callback: Called with a range and its token.
    ///
    /// - throws: A ParserError
    public class func parse(_ code: String, with lexer: String, callback: ParserCallback) throws {
        let tokens = try tokenize(code, with: lexer)
        
        let codeNS = code as NSString
        var index = 0
        for token in tokens where index < codeNS.length {
            let range = codeNS.range(of: token.payload, options: [], range: NSRange(index..<codeNS.length))
            index += (token.payload as NSString).length
            
            callback(range, token)
        }
    }
}

/// Parse a string and return the tokens, their associated range, and attributes for an NSAttributedString
public class AttributedParser {
    public typealias AttributedParserCallback = (_ range: NSRange, _ token: Token, _ attributes: [String: Any]) -> Void
    
    @available(*, unavailable)
    private init() { }
    
    /// Parse a code string using a pygments lexer and colour it with the provided theme,
    /// returning attributes that can be used with an NSAttributedString.
    ///
    /// - parameter code:     Code to parse.
    /// - parameter lexer:    Lexer to tokenise with.
    /// - parameter theme:    Theme to use for generating NSAttributedString attributes.
    /// - parameter callback: Called with a range, its token, and attributes.
    ///
    /// - throws: A ParserError
    public class func parse(_ code: String, with lexer: String, theme: Theme, callback: AttributedParserCallback) throws {
        try Parser.parse(code, with: lexer) { (range, token) in
            guard let scopeSelector = token.kind.scope,
                let scope = theme.resolveScope(selector: scopeSelector) else {
                    return
            }
            
            // Populate attributes
            var attributes = [String: Any]()
            if let foreground = scope.foreground {
                attributes[NSForegroundColorAttributeName] = foreground
            }
            
            if let background = scope.background {
                attributes[NSBackgroundColorAttributeName] = background
            }
            // Ignore font styles for now.
            // TODO: Don't ignore font styles 
//            if let fontStyles = scope.fontStyles {
//            }
            
            // emit range and attributes
            callback(range, token, attributes)
        }
    }
}
