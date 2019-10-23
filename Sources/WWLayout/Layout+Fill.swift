//
//===----------------------------------------------------------------------===//
//
//  Layout+Fill.swift
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
    
    // MARK: - Fill with optional axis
    
    /// Set the view so it fills another view.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ other: Anchorable, axis: LayoutAxis = .xy, inset: Insets? = nil, priority: LayoutPriority? = nil) -> Layout {
        let inset = inset ?? .zero
        if axis == .x || axis == .xy {
            make(LayoutXEdge.left, .equal, toItem: other.anchor(.left), constant: inset.left, priority: priority)
            make(LayoutXEdge.right, .equal, toItem: other.anchor(.right), constant: -inset.right, priority: priority)
        }
        if axis == .y || axis == .xy {
            make(LayoutYEdge.top, .equal, toItem: other.anchor(.top), constant: inset.top, priority: priority)
            make(LayoutYEdge.bottom, .equal, toItem: other.anchor(.bottom), constant: -inset.bottom, priority: priority)
        }
        return self
    }
    
    /// Set the view so it fills another view.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ other: Anchorable, axis: LayoutAxis = .xy, inset: CGFloat, priority: LayoutPriority? = nil) -> Layout {
        return fill(other, axis: axis, inset: Insets(inset), priority: priority)
    }
    
    /// Set the view so it fills special anchors.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `special`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ special: SpecialAnchorable, axis: LayoutAxis = .xy, inset: Insets? = nil, priority: LayoutPriority? = nil) -> Layout {
        return fill(special.anchorable(with: view), axis: axis, inset: inset, priority: priority)
    }
    
    /// Set the view so it fills another view.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ special: SpecialAnchorable, axis: LayoutAxis = .xy, inset: CGFloat, priority: LayoutPriority? = nil) -> Layout {
        return fill(special, axis: axis, inset: Insets(inset), priority: priority)
    }
    
    // MARK: - Fill except one edge
    
    /// Set the view so it fills another view - excluding one edge.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ other: Anchorable, except: LayoutFillEdge, inset: Insets? = nil, priority: LayoutPriority? = nil) -> Layout {
        let inset = inset ?? .zero
        if except != .left {
            make(LayoutXEdge.left, .equal, toItem: other.anchor(.left), constant: inset.left, priority: priority)
        }
        if except != .right {
            make(LayoutXEdge.right, .equal, toItem: other.anchor(.right), constant: -inset.right, priority: priority)
        }
        if except != .top {
            make(LayoutYEdge.top, .equal, toItem: other.anchor(.top), constant: inset.top, priority: priority)
        }
        if except != .bottom {
            make(LayoutYEdge.bottom, .equal, toItem: other.anchor(.bottom), constant: -inset.bottom, priority: priority)
        }
        return self
    }
    
    /// Set the view so it fills another view - excluding one edge.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ other: Anchorable, except: LayoutFillEdge, inset: CGFloat, priority: LayoutPriority? = nil) -> Layout {
        return fill(other, except: except, inset: Insets(inset), priority: priority)
    }
    
    /// Set the view so it fills special anchors - excluding one edge.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `special`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ special: SpecialAnchorable, except: LayoutFillEdge, inset: Insets? = nil, priority: LayoutPriority? = nil) -> Layout {
        return fill(special.anchorable(with: view), except: except, inset: inset, priority: priority)
    }
    
    /// Set the view so it fills another view - excluding one edge.
    /// Will constrain the edges (left, top, bottom, right) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func fill(_ special: SpecialAnchorable, except: LayoutFillEdge, inset: CGFloat, priority: LayoutPriority? = nil) -> Layout {
        return fill(special, except: except, inset: Insets(inset), priority: priority)
    }
    
    // MARK: - Fill width with maximum
    
    /// Set the view so it fills the width of another view, with a maximum allowed width.
    /// Will constrain:
    ///     the left & right edges of the target view to the edges of `other` at `priority` - 1;
    ///     the width to be <= `maximum`
    ///     the `alignTo` edge to the same ot `other`.
    @discardableResult
    public func fillWidth(of other: Anchorable, inset: Insets? = nil, maximum: CGFloat, alignTo edge: LayoutXEdge = .center, priority: LayoutPriority? = nil) -> Layout {
        let inset = inset ?? .zero
        let priority = priority ?? self.priority
        fill(other, axis: .x, inset: inset, priority: priority - 1)
        width(.lessOrEqual, to: maximum)
        switch edge {
        case .left: left(to: other, offset: inset.left)
        case .right: right(to: other, offset: -inset.right)
        case .center: centerX(to: other)
        case .leading: leading(to: other, offset: inset.left)
        case .trailing: trailing(to: other, offset: -inset.right)
        }
        return self
    }
    
    /// Set the view so it fills the width of another view, with a maximum allowed width.
    /// Will constrain:
    ///     the left & right edges of the target view to the edges of `other` at `priority` - 1;
    ///     the width to be <= `maximum`
    ///     the `alignTo` edge to the same ot `other`.
    @discardableResult
    public func fillWidth(of other: Anchorable, inset: CGFloat, maximum: CGFloat, alignTo edge: LayoutXEdge = .center, priority: LayoutPriority? = nil) -> Layout {
        return fillWidth(of: other, inset: Insets(inset), maximum: maximum, alignTo: edge, priority: priority)
    }
    
    /// Set the view so it fills the width of another view, with a maximum allowed width.
    /// Will constrain:
    ///     the left & right edges of the target view to the edges of `special` at `priority` - 1;
    ///     the width to be <= `maximum`
    ///     the `alignTo` edge to the same of `special`.
    @discardableResult
    public func fillWidth(of special: SpecialAnchorable, inset: Insets? = nil, maximum: CGFloat, alignTo edge: LayoutXEdge = .center, priority: LayoutPriority? = nil) -> Layout {
        return fillWidth(of: special.anchorable(with: view), inset: inset, maximum: maximum, alignTo: edge, priority: priority)
    }
    
}
