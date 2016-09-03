//
//  Theme.swift
//  PygmentsKit
//
//  Created by Nik on 01/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Foundation

// MARK: Scope -
struct Scope {
    enum FontStyle: String {
        case bold = "bold"
        case italic = "italic"
    }
    
    var fontStyles: [FontStyle]?
    var foreground: NSColor?
    var background: NSColor?
}


// MARK: Scope Equatable implementation -
extension Scope: Equatable {
    static func ==(lhs: Scope, rhs: Scope) -> Bool {
        let fontStylesEqual: Bool = {
            if lhs.fontStyles == nil && rhs.fontStyles == nil {
                return true
            }
            
            if let lhs = lhs.fontStyles, let rhs = rhs.fontStyles {
                return lhs.elementsEqual(rhs)
            }
            
            return false
        }()
        
        return fontStylesEqual &&
            optionalsEqual(lhs.foreground, rhs.foreground) &&
            optionalsEqual(lhs.background, rhs.background)
    }
}

// MARK: Theme -
/// Represents a tmTheme in memory
public struct Theme {
    
    // Scopes
    private let scopes: [String: Scope]
    
    // Global setting keys
    public enum Global {
        case foreground
        case background
        case invisibles
        case caret
        case lineHighlight
        
        case gutter
        case gutterForeground
        
        case selection
        case selectionBackground
        case selectionBorder
        case inactiveSelection
        
        case guide
        case activeGuide
        case stackGuide
        
        case highlight
        case highlightForeground
    }
    
    public let global: [Global: NSColor]
    
    public init?(data: [NSObject: AnyObject]) {
        guard let settings = data["settings" as NSString] as? [[String: Any]],
            settings.count != 0 else {
            print("No settings")
            return nil
        }
        
        // MARK: Get global settings
        let globalSettings = settings.first!["settings"] as! [String: String]
        var globalTemp = [Global: NSColor]()
        
        if let color = Theme.getColor(globalSettings["foreground"]) {
            globalTemp[.foreground] = color
        }
        
        if let color = Theme.getColor(globalSettings["background"]) {
            globalTemp[.background] = color
        }
        
        if let color = Theme.getColor(globalSettings["invisibles"]) {
            globalTemp[.invisibles] = color
        }
        
        if let color = Theme.getColor(globalSettings["caret"]) {
            globalTemp[.caret] = color
        }
        
        if let color = Theme.getColor(globalSettings["lineHighlight"]) {
            globalTemp[.lineHighlight] = color
        }
        
        if let color = Theme.getColor(globalSettings["gutter"]) {
            globalTemp[.gutter] = color
        }
        
        if let color = Theme.getColor(globalSettings["gutterForeground"]) {
            globalTemp[.gutterForeground] = color
        }
        
        if let color = Theme.getColor(globalSettings["selection"]) {
            globalTemp[.selection] = color
        }
        
        if let color = Theme.getColor(globalSettings["selectionBackground"]) {
            globalTemp[.selectionBackground] = color
        }
        
        if let color = Theme.getColor(globalSettings["selectionBorder"]) {
            globalTemp[.selectionBorder] = color
        }
        
        if let color = Theme.getColor(globalSettings["inactiveSelection"]) {
            globalTemp[.inactiveSelection] = color
        }
        
        if let color = Theme.getColor(globalSettings["guide"]) {
            globalTemp[.guide] = color
        }
        
        if let color = Theme.getColor(globalSettings["activeGuide"]) {
            globalTemp[.activeGuide] = color
        }
        
        if let color = Theme.getColor(globalSettings["stackGuide"]) {
            globalTemp[.stackGuide] = color
        }
        
        if let color = Theme.getColor(globalSettings["highlight"]) {
            globalTemp[.highlight] = color
        }
        
        if let color = Theme.getColor(globalSettings["highlightForeground"]) {
            globalTemp[.highlightForeground] = color
        }
        
        self.global = globalTemp
        
        // MARK: Set up scopes
        var setUpScopes = [String: Scope]()
        
        // Loop through each scope
        for scope in settings {
            guard let settings = scope["settings"] as? [String: Any],
                let scopeSelectors = scope["scope"] as? String else { continue }
            
            // Set up the scope object
            var scopeObj = Scope()
            scopeObj.fontStyles = {
                guard let fontStyleString = settings["fontStyle"] as? String else { return nil }
                
                var fontStyles: [Scope.FontStyle] = []
                for component in fontStyleString.components(separatedBy: .whitespaces) {
                    guard let style = Scope.FontStyle(rawValue: component) else { continue }
                    
                    fontStyles.append(style)
                }
                
                // if there are no font styles, return nil
                return fontStyles.isEmpty ? nil : fontStyles
            }()
            scopeObj.foreground = {
                guard let color = settings["foreground"] as? String else { return nil }
                
                return NSColor(fromHex: color)
            }()
            scopeObj.background = {
                guard let color = settings["background"] as? String else { return nil }
                
                return NSColor(fromHex: color)
            }()
            
            // Set up the scopes
            let activeSelectors = scopeSelectors.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            for activeScope in activeSelectors {
                setUpScopes[activeScope] = scopeObj // copy-on-write should mean that multiple scopes are ok
            }
        }
        
        // Assign scopes for this theme
        self.scopes = setUpScopes
    }
    
    /// Resolve a scope using its selector.
    /// This method will find the most specific scope for the provided selector.
    ///
    /// - parameter selector: Selector that identifies a scope, e.g. `variable.language`.
    ///
    /// - returns: A scope struct that represents a scope in memory or nil if no scope exists
    ///            for the given selector.
    func resolveScope(selector: String) -> Scope? {
        if let scope = scopes[selector] {
            return scope
        }
        
        // TODO: Implement lateral selectors properly.
        var selectorComponents = selector.components(separatedBy: ".")
        // If the count is not greater than 1, this scope was not general enough
        // and no further scopes exist
        if selectorComponents.count > 1 {
            selectorComponents.removeLast()
            
            // Resolve a more general scope
            return resolveScope(selector: selectorComponents.joined(separator: "."))
        }
        
        return nil
    }
    
    /// A utility function to initialise colours based on their hex values or return nil
    ///
    /// - parameter string: Hex value for the colour to initialise.
    ///
    /// - returns: An NSColour instance for the provided hex value or nil if
    ///            the hex value is invalid or the colour does not exist.
    private static func getColor(_ string: String?) -> NSColor? {
        guard let colorString = string else {
            return nil
        }
        
        return NSColor(fromHex: colorString)
    }
}
