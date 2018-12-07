//
//===----------------------------------------------------------------------===//
//
//  LayoutEdge.swift
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

/// An edge of an anchorable item
protocol LayoutEdge {
    associatedtype Axis
    var attribute: LayoutConstraint.Attribute { get }
}

/// An edge used for vertical positioning
public enum LayoutYEdge: LayoutEdge {
    typealias Axis = LayoutYEdge
    case top
    case bottom
    case center
    case firstBaseline
    case lastBaseline
    
    var attribute: LayoutConstraint.Attribute {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .center: return .centerY
        case .firstBaseline: return .firstBaseline
        case .lastBaseline: return .lastBaseline
        }
    }
}

/// An edge used for horizontal positioning
public enum LayoutXEdge: LayoutEdge {
    typealias Axis = LayoutXEdge
    case left
    case right
    case leading
    case trailing
    case center
    
    var attribute: LayoutConstraint.Attribute {
        switch self {
        case .left: return .left
        case .right: return .right
        case .leading: return .leading
        case .trailing: return .trailing
        case .center: return .centerX
        }
    }
}

/// A single edge - used to exclude an edge from filling another view
public enum LayoutFillEdge {
    case left
    case right
    case top
    case bottom
}

/// Width or height dimension
public enum LayoutDimensionEdge: LayoutEdge {
    typealias Axis = LayoutDimensionEdge
    case width
    case height
    
    var attribute: LayoutConstraint.Attribute {
        switch self {
        case .width: return .width
        case .height: return .height
        }
    }
}
