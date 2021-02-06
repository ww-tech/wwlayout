//
// ===----------------------------------------------------------------------===//
//
//  LayoutAnchor.swift
//
//  Created by Steven Grosmark on 2/19/18.
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

/// Something that one side of a constraint relationship can be attached to
public protocol LayoutAnchor {
    associatedtype Axis
    var item: Any { get }
    var attribute: LayoutConstraint.Attribute { get }
}

public struct LayoutXAnchor: LayoutAnchor {
    public typealias Axis = LayoutXEdge
    public let item: Any
    public let attribute: LayoutConstraint.Attribute
}

public struct LayoutYAnchor: LayoutAnchor {
    public typealias Axis = LayoutYEdge
    public let item: Any
    public let attribute: LayoutConstraint.Attribute
}

public struct LayoutDimensionAnchor: LayoutAnchor {
    public typealias Axis = LayoutDimensionEdge
    public let item: Any
    public let attribute: LayoutConstraint.Attribute
}
