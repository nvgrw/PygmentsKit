//
//  Theme.swift
//  PygmentsKit
//
//  Created by Nik on 01/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Foundation

struct Scope {
    enum FontStyle: String {
        case bold = "bold"
        case italic = "italic"
    }
    
    var fontStyle: FontStyle?
    var foreground: NSColor?
    var background: NSColor?
}

/// Represents a tmTheme in memory
public struct Theme {
    
    let scopes: [String: Scope]
    
    public init?(data: [NSObject: AnyObject]) {
        guard let settings = data["settings" as NSString] as? [[String: Any]] else {
            print("No settings")
            return nil
        }
        
        var setUpScopes = [String: Scope]()
        
        // Loop through each scope
        for scope in settings {
            guard let settings = scope["settings"] as? [String: Any],
                let scopeSelectors = scope["scope"] as? String else { continue }
            
            // Set up the scope object
            var scopeObj = Scope()
            scopeObj.fontStyle = Scope.FontStyle(rawValue: (settings["fontStyle"] as? String) ?? "")
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
}
