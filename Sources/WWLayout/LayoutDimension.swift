//
// ===----------------------------------------------------------------------===//
//
//  LayoutDimension.swift
//
//  Created by Steven Grosmark on 11/23/17.
//  Copyright © 2018 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2021 WW International, Inc.
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
// ===----------------------------------------------------------------------===//
//

import UIKit

/// A sizing relationship (i.e. a width or height anchor, plus a multiplier & offset)
/// The `item` + `attribute` define the source dimension
/// `multiplier` and `offset` define modifications to the source dimension's value
public protocol LayoutDimension {
    var item: Any { get }
    var attribute: LayoutConstraint.Attribute { get }
    var multiplier: CGFloat { get }
    var offset: CGFloat { get }
}

// Defaults for multiplier & constant
public extension LayoutDimension {
    var multiplier: CGFloat { return 1.0 }
    var offset: CGFloat { return 0.0 }
}

/// The initial dimension represents the base dimension, that can be multiplied or added to
public struct InitialLayoutDimension: LayoutDimension {
    public let item: Any
    public let attribute: LayoutConstraint.Attribute
    
    init(_ item: Any, _ attribute: LayoutConstraint.Attribute) {
        self.item = item
        self.attribute = attribute
    }
    
    public static func * (_ lhs: InitialLayoutDimension, _ rhs: CGFloat) -> SpecifiedLayoutDimension {
        return SpecifiedLayoutDimension(lhs.item, lhs.attribute, multiplier: rhs)
    }
    
    public static func + (_ lhs: InitialLayoutDimension, _ rhs: CGFloat) -> LayoutDimension {
        return SpecifiedLayoutDimension(lhs.item, lhs.attribute, multiplier: lhs.multiplier, offset: lhs.offset + rhs)
    }
    
    public static func - (_ lhs: InitialLayoutDimension, _ rhs: CGFloat) -> LayoutDimension {
        return SpecifiedLayoutDimension(lhs.item, lhs.attribute, multiplier: lhs.multiplier, offset: lhs.offset - rhs)
    }
}

/// A specified dimension represents a dimension that has had a multiplier or an offset applied,
/// and can only be further modified by an offset amount
public struct SpecifiedLayoutDimension: LayoutDimension {
    public let item: Any
    public let attribute: LayoutConstraint.Attribute
    public let multiplier: CGFloat
    public let offset: CGFloat
    
    init(_ item: Any, _ attribute: LayoutConstraint.Attribute, multiplier: CGFloat = 1.0, offset: CGFloat = 0) {
        self.item = item
        self.attribute = attribute
        self.multiplier = multiplier
        self.offset = offset
    }
    
    public static func + (_ lhs: SpecifiedLayoutDimension, _ rhs: CGFloat) -> LayoutDimension {
        return SpecifiedLayoutDimension(lhs.item, lhs.attribute, multiplier: lhs.multiplier, offset: lhs.offset + rhs)
    }
    
    public static func - (_ lhs: SpecifiedLayoutDimension, _ rhs: CGFloat) -> LayoutDimension {
        return SpecifiedLayoutDimension(lhs.item, lhs.attribute, multiplier: lhs.multiplier, offset: lhs.offset - rhs)
    }
}
