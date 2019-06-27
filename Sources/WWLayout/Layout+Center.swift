//
//===----------------------------------------------------------------------===//
//
//  Layout+Center.swift
//
//  Created by Steven Grosmark on 12/9/17.
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

extension Layout {
    
    /// Center the view relative to another
    @discardableResult
    public func center(in other: Anchorable, axis: LayoutAxis = .xy, priority: LayoutPriority? = nil, tag: Int? = nil, active: Bool? = nil) -> Layout {
        if axis == .x || axis == .xy {
            make(LayoutXEdge.center, .equal, toItem: other.anchor(.center), priority: priority, tag: tag, active: active)
        }
        if axis == .y || axis == .xy {
            make(LayoutYEdge.center, .equal, toItem: other.anchor(.center), priority: priority, tag: tag, active: active)
         }
        return self
    }
    
    /// Center the view relative to something special
    @discardableResult
    public func center(in special: SpecialAnchorable, axis: LayoutAxis = .xy, priority: LayoutPriority? = nil, tag: Int? = nil, active: Bool? = nil) -> Layout {
        return center(in: special.anchorable(with: view), axis: axis, priority: priority, tag: tag, active: active)
    }
    
}
