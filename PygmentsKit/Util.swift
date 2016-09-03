//
//  Util.swift
//  PygmentsKit
//
//  Created by Nik on 02/09/2016.
//  Copyright © 2016 Niklas Vangerow. All rights reserved.
//

import Foundation

/// Compare two values that are optional.
///
/// Returns true if both values are equal or both values are nil.
///
/// - parameter lhs: Left hand argument
/// - parameter rhs: Right hand argument
///
/// - returns: Boolean indicating whether the arguments are equal or not
func optionalsEqual<T: Equatable>(_ lhs: T?, _ rhs: T?) -> Bool {
    if lhs == nil && rhs == nil {
        return true
    }
    
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    }
    
    return false
}
