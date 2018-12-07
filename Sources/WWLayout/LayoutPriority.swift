//
//===----------------------------------------------------------------------===//
//
//  LayoutPriority.swift
//
//  Created by Steven Grosmark on 11/23/17.
//  Copyright © 2018 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2018 WW International, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//===----------------------------------------------------------------------===//
//

import UIKit

/*
 Using a typealias to Float seems simpler, and avoids some extra wonky compiler fixits when
 passing non-Float varibles into the funcs that expect a LayoutPriority.
 With the struct, the fixit offers `LayoutPriority(rawValue: Float(myVar))`.
 With the typealias, the fixit just offers `LayoutPriority(myVar)`.
 
 However, using a struct (like UILayoutPriority does as of Swift 4), allows it to enforce
 the 0-1000 range of values.
 With the typealias, intermediate LayoutPriority variables can hold out-of-range values,
 and the range clamping has to be done when creating a UILayoutPriority from a LayoutPriority.
 With the struct, the range clamping is done on creation.
 */
/*
 public typealias LayoutPriority = Float
 
 public extension LayoutPriority {
 public static let required: LayoutPriority = 1000
 public static let high: LayoutPriority = 500
 public static let low: LayoutPriority = 250
 }
 */

/// LayoutConstraint priority, corresponds dirctly to UILayoutPriority
public struct LayoutPriority: RawRepresentable {
    public private(set) var rawValue: Float
    public init(rawValue: Float) {
        self.rawValue = min(1000, max(0, rawValue))
    }
    public static let required = LayoutPriority(rawValue: 1000)
    public static let high = LayoutPriority(rawValue: 750)
    public static let low = LayoutPriority(rawValue: 250)
}

// MARK: - Int and Float literals

extension LayoutPriority: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    
    public init(integerLiteral: Int) {
        self.init(rawValue: Float(integerLiteral))
    }
    
    public init(floatLiteral: Float) {
        self.init(rawValue: floatLiteral)
    }
    
}

// MARK: - Equality

extension LayoutPriority: Equatable {
    
    public static func == (_ lhs: LayoutPriority, _ rhs: LayoutPriority) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
}

// MARK: - Addition and subtraction support

extension LayoutPriority {
    
    // swiftlint:disable shorthand_operator
    public static func += (_ lhs: inout LayoutPriority, _ integerLiteral: Int) {
        lhs = lhs + integerLiteral
    }
    
    public static func += (_ lhs: inout LayoutPriority, _ floatLiteral: Float) {
        lhs = lhs + floatLiteral
    }
    
    public static func -= (_ lhs: inout LayoutPriority, _ integerLiteral: Int) {
        lhs = lhs - integerLiteral
    }
    
    public static func -= (_ lhs: inout LayoutPriority, _ floatLiteral: Float) {
        lhs = lhs - floatLiteral
    }
    
    public static func + (_ lhs: LayoutPriority, _ integerLiteral: Int) -> LayoutPriority {
        return LayoutPriority(rawValue: lhs.rawValue + Float(integerLiteral))
    }
    
    public static func + (_ lhs: LayoutPriority, _ floatLiteral: Float) -> LayoutPriority {
        return LayoutPriority(rawValue: lhs.rawValue + floatLiteral)
    }
    
    public static func - (_ lhs: LayoutPriority, _ integerLiteral: Int) -> LayoutPriority {
        return LayoutPriority(rawValue: lhs.rawValue - Float(integerLiteral))
    }
    
    public static func - (_ lhs: LayoutPriority, _ floatLiteral: Float) -> LayoutPriority {
        return LayoutPriority(rawValue: lhs.rawValue - floatLiteral)
    }
    
}
