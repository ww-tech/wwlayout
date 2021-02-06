//
// ===----------------------------------------------------------------------===//
//
//  Layout+Edges.swift
//
//  Created by Steven Grosmark on 12/9/17.
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

extension Layout {
    
    // MARK: - Vertical edges
    
    /// Set the top edge relative to another view
    /// - parameter relation: optional .equal, .lessOrEqual, or .greaterOrEqual. Defaults to .equal
    /// - parameter to: the other view (or special Anchorable) in the constraint relationship
    /// - parameter edge: the edge on the other view to connect the top edge of this view to. Defaults to .top
    /// - parameter offset: a constant offset for the underlying constraint. Defaults to 0
    /// - parameter priority: The priority at which to create the constraint. Defaults to priority of the layout (.required unless that, too is overridden)
    ///
    /// Examples
    /// ```swift
    ///     // sets top of this to top of view2
    ///     top(to: view2)
    ///
    ///     // sets top of this to bottom of view2 plus 20pt
    ///     top(to: view2, edge: .bottom, offset: 10)
    ///
    ///     top(.lessOrEqual, to: view2)
    @discardableResult
    public func top(_ relation: LayoutRelation = .equal,
                    to other: Anchorable,
                    edge: LayoutYEdge = .top,
                    offset: CGFloat = 0,
                    priority: LayoutPriority? = nil,
                    tag: Int? = nil,
                    active: Bool? = nil) -> Layout {
        make(LayoutYEdge.top, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the top edge relative to a special set of anchors
    /// - parameter relation: optional .equal, .lessOrEqual, or .greaterOrEqual. Defaults to .equal
    /// - parameter to: the other Anchorable (.superview, .margins, or .safeArea) in the constraint relationship
    /// - parameter edge: the edge on the other Anchorable to connect the top edge of this view to. Defaults to .top
    /// - parameter offset: a constant offset for the underlying constraint. Defaults to 0
    /// - parameter priority: The priority at which to create the constraint. Defaults to priority of the layout (.required unless that, too is overridden)
    ///
    /// Examples
    /// ```swift
    ///     // sets top of this to top of view2
    ///     top(to: .superview)
    ///
    ///     // sets top of this to bottom of view2 plus 20pt
    ///     top(to: .safeArea, edge: .bottom, offset: 10)
    ///
    ///     top(.lessOrEqual, to: .margins)
    @discardableResult
    public func top(_ relation: LayoutRelation = .equal,
                    to special: SpecialAnchorable,
                    edge: LayoutYEdge = .top,
                    offset: CGFloat = 0,
                    priority: LayoutPriority? = nil,
                    tag: Int? = nil,
                    active: Bool? = nil) -> Layout {
        return top(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the bottom edge relative to another view
    @discardableResult
    public func bottom(_ relation: LayoutRelation = .equal,
                       to other: Anchorable,
                       edge: LayoutYEdge = .bottom,
                       offset: CGFloat = 0,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        make(LayoutYEdge.bottom, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the bottom edge relative to a special set of anchors
    @discardableResult
    public func bottom(_ relation: LayoutRelation = .equal,
                       to special: SpecialAnchorable,
                       edge: LayoutYEdge = .bottom,
                       offset: CGFloat = 0,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        return bottom(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the center y edge relative to another view
    @discardableResult
    public func centerY(_ relation: LayoutRelation = .equal,
                        to other: Anchorable,
                        edge: LayoutYEdge = .center,
                        offset: CGFloat = 0,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        make(LayoutYEdge.center, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the center y edge relative to a special set of anchors
    @discardableResult
    public func centerY(_ relation: LayoutRelation = .equal,
                        to special: SpecialAnchorable,
                        edge: LayoutYEdge = .center,
                        offset: CGFloat = 0,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        return centerY(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the first baseline relative to another view
    @discardableResult
    public func firstBaseline(_ relation: LayoutRelation = .equal,
                              to other: Anchorable,
                              edge: LayoutYEdge = .firstBaseline,
                              offset: CGFloat = 0,
                              priority: LayoutPriority? = nil,
                              tag: Int? = nil,
                              active: Bool? = nil) -> Layout {
        make(LayoutYEdge.firstBaseline, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the bottom edge relative to a special set of anchors
    @discardableResult
    public func firstBaseline(_ relation: LayoutRelation = .equal,
                              to special: SpecialAnchorable,
                              edge: LayoutYEdge = .firstBaseline,
                              offset: CGFloat = 0,
                              priority: LayoutPriority? = nil,
                              tag: Int? = nil,
                              active: Bool? = nil) -> Layout {
        return firstBaseline(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the first baseline relative to another view
    @discardableResult
    public func lastBaseline(_ relation: LayoutRelation = .equal,
                             to other: Anchorable,
                             edge: LayoutYEdge = .lastBaseline,
                             offset: CGFloat = 0,
                             priority: LayoutPriority? = nil,
                             tag: Int? = nil,
                             active: Bool? = nil) -> Layout {
        make(LayoutYEdge.lastBaseline, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the bottom edge relative to a special set of anchors
    @discardableResult
    public func lastBaseline(_ relation: LayoutRelation = .equal,
                             to special: SpecialAnchorable,
                             edge: LayoutYEdge = .lastBaseline,
                             offset: CGFloat = 0,
                             priority: LayoutPriority? = nil,
                             tag: Int? = nil,
                             active: Bool? = nil) -> Layout {
        return lastBaseline(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    // MARK: - Horizontal edges
    
    /// Set the left edge relative to another view
    @discardableResult
    public func left(_ relation: LayoutRelation = .equal,
                     to other: Anchorable,
                     edge: LayoutXEdge = .left,
                     offset: CGFloat = 0,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        make(LayoutXEdge.left, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the left edge relative to a special set of anchors
    @discardableResult
    public func left(_ relation: LayoutRelation = .equal,
                     to special: SpecialAnchorable,
                     edge: LayoutXEdge = .left,
                     offset: CGFloat = 0,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        return left(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the right edge relative to another view
    @discardableResult
    public func right(_ relation: LayoutRelation = .equal,
                      to other: Anchorable,
                      edge: LayoutXEdge = .right,
                      offset: CGFloat = 0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        make(LayoutXEdge.right, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the right edge relative to a special set of anchors
    @discardableResult
    public func right(_ relation: LayoutRelation = .equal,
                      to special: SpecialAnchorable,
                      edge: LayoutXEdge = .right,
                      offset: CGFloat = 0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        return right(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the center x edge relative to another view
    @discardableResult
    public func centerX(_ relation: LayoutRelation = .equal,
                        to other: Anchorable,
                        edge: LayoutXEdge = .center,
                        offset: CGFloat = 0,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        make(LayoutXEdge.center, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the center x edge relative to a special set of anchors
    @discardableResult
    public func centerX(_ relation: LayoutRelation = .equal,
                        to special: SpecialAnchorable,
                        edge: LayoutXEdge = .center,
                        offset: CGFloat = 0,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        return centerX(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the leading edge relative to another view
    @discardableResult
    public func leading(_ relation: LayoutRelation = .equal,
                        to other: Anchorable,
                        edge: LayoutXEdge = .leading,
                        offset: CGFloat = 0,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        make(LayoutXEdge.leading, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the leading edge relative to a special set of anchors
    @discardableResult
    public func leading(_ relation: LayoutRelation = .equal,
                        to special: SpecialAnchorable,
                        edge: LayoutXEdge = .leading,
                        offset: CGFloat = 0,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        return leading(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Set the trailing edge relative to another view
    @discardableResult
    public func trailing(_ relation: LayoutRelation = .equal,
                         to other: Anchorable,
                         edge: LayoutXEdge = .trailing,
                         offset: CGFloat = 0,
                         priority: LayoutPriority? = nil,
                         tag: Int? = nil,
                         active: Bool? = nil) -> Layout {
        make(LayoutXEdge.trailing, relation, toItem: other.anchor(edge), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the trailing edge relative to a special set of anchors
    @discardableResult
    public func trailing(_ relation: LayoutRelation = .equal,
                         to special: SpecialAnchorable,
                         edge: LayoutXEdge = .trailing,
                         offset: CGFloat = 0,
                         priority: LayoutPriority? = nil,
                         tag: Int? = nil,
                         active: Bool? = nil) -> Layout {
        return trailing(relation, to: special.anchorable(with: view), edge: edge, offset: offset, priority: priority, tag: tag, active: active)
    }
    
}
