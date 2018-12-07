//
//===----------------------------------------------------------------------===//
//
//  Insets.swift
//
//  Created by Steven Grosmark on 12/1/17.
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

/// Insets
/// Simple struct for managing insets
/// Positive numbers represent an inset that is inside - or smaller - than a reference object.
/// Negative numbers represent an inset that is outside - or larger - than a reference object.
public struct Insets {
    public var top: CGFloat
    public var left: CGFloat
    public var bottom: CGFloat
    public var right: CGFloat
    
    public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.top = top
        self.left = left
        self.right = right
        self.bottom = bottom
    }
}

public extension Insets {
    public static let zero = Insets(0)
}

public extension Insets {
    
    /// Set all edges of the inset to the same amount.
    public init(_ allEdgesAmount: CGFloat) {
        top = allEdgesAmount
        left = allEdgesAmount
        bottom = allEdgesAmount
        right = allEdgesAmount
    }
    
    /// Set horizontal, vertical edges of the inset to a specific amount.
    public init(_ leftRightAmount: CGFloat, _ topBottomAmount: CGFloat) {
        top = topBottomAmount
        left = leftRightAmount
        bottom = topBottomAmount
        right = leftRightAmount
    }
    
    /// Create an Insets instance from a UIEdgeInsets object
    public init(_ edgeInsets: UIEdgeInsets) {
        top = edgeInsets.top
        left = edgeInsets.left
        bottom = edgeInsets.bottom
        right = edgeInsets.right
    }
}

extension Insets: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public init(integerLiteral: Int) {
        self.init(CGFloat(integerLiteral))
    }
    public init(floatLiteral: Float) {
        self.init(CGFloat(floatLiteral))
    }
}

extension Insets: Equatable {
    public static func == (lhs: Insets, rhs: Insets) -> Bool {
        return lhs.top == rhs.top
            && lhs.left == rhs.left
            && lhs.bottom == rhs.bottom
            && lhs.right == rhs.right
    }
}
