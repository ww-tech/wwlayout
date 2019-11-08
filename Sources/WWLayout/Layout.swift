//
//===----------------------------------------------------------------------===//
//
//  Layout.swift
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

/// Holds a reference to the view, so layout calls can be chained
public final class Layout {
    
    internal let view: UIView
    internal let priority: LayoutPriority
    internal var newConstraints: [LayoutConstraint]
    private let tag: Int
    private let sizeClass: SizeClass?
    private let active: Bool
    
    internal init(_ view: UIView,
                  priority: LayoutPriority = .required,
                  tag: Int = 0,
                  active: Bool = true) {
        self.view = view
        self.priority = priority
        self.tag = tag
        self.sizeClass = nil
        self.active = active
        newConstraints = []
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    internal init(_ view: UIView,
                  priority: LayoutPriority = .required,
                  horizontalSize: UIUserInterfaceSizeClass,
                  verticalSize: UIUserInterfaceSizeClass) {
        self.view = view
        self.priority = priority
        self.sizeClass = SizeClass(horizontal: horizontalSize, vertical: verticalSize)
        tag = 0
        let traitEnvironment: UITraitEnvironment? = view.owningViewController() ?? UIApplication.shared.keyWindow
        active = traitEnvironment?.traitCollection.isActive(horizontalSize: horizontalSize, verticalSize: verticalSize) != false
        newConstraints = []
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Internal constraint creation
    
    /// Helper to constrain edge (==|<=|>=) rhs * multiplier + constant
    internal func make<Edge, Anchor>(_ edge: Edge,
                                     _ relation: LayoutRelation,
                                     toItem rhs: Anchor,
                                     multiplier: CGFloat = 1.0,
                                     constant: CGFloat = 0.0,
                                     priority: LayoutPriority? = nil,
                                     tag: Int? = nil,
                                     active: Bool? = nil)
        where Edge: LayoutEdge, Anchor: LayoutAnchor, Edge.Axis == Anchor.Axis {
        
        let constraint = LayoutConstraint(item: view,
                                          attribute: edge.attribute,
                                          relatedBy: relation.nsRelation,
                                          toItem: rhs.item,
                                          attribute: rhs.attribute,
                                          multiplier: multiplier,
                                          constant: constant)
        constraint.tag = tag ?? self.tag
        collect(constraint, at: priority, active: active)
    }
    
    /// Helper to constrain edge (==|<=|>=) constant
    internal func make<Edge>(_ edge: Edge,
                             _ relation: LayoutRelation,
                             to constant: CGFloat,
                             priority: LayoutPriority? = nil,
                             tag: Int? = nil,
                             active: Bool? = nil)
        where Edge: LayoutEdge {
        
        let constraint = LayoutConstraint(item: view,
                                          attribute: edge.attribute,
                                          relatedBy: relation.nsRelation,
                                          toItem: nil,
                                          attribute: .notAnAttribute,
                                          multiplier: 1.0,
                                          constant: constant)
        constraint.tag = tag ?? self.tag
        collect(constraint, at: priority, active: active)
    }
    
    /// Helper to constrain edge (==|<=|>=) dimension (edge * multiplier + constant)
    internal func make(_ edge: LayoutDimensionEdge,
                       _ relation: LayoutRelation,
                       to dimension: LayoutDimension,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) {
        
        let constraint = LayoutConstraint(item: view,
                                          attribute: edge.attribute,
                                          relatedBy: relation.nsRelation,
                                          toItem: dimension.item,
                                          attribute: dimension.attribute,
                                          multiplier: dimension.multiplier,
                                          constant: dimension.offset)
        constraint.tag = tag ?? self.tag
        collect(constraint, at: priority, active: active)
    }
    
    private func collect(_ constraint: LayoutConstraint,
                         at priority: LayoutPriority? = nil,
                         active: Bool? = nil) {
        newConstraints.append(constraint.set(priority: priority ?? self.priority, active: active ?? self.active))
        if constraint.tag != 0 {
            layoutView.add(constraint)
        }
        if let sizeClass = sizeClass {
            layoutView.add(constraint, sizeClass: sizeClass)
        }
    }
    
    private var layoutView: LayoutView {
        if _layoutView == nil { _layoutView = LayoutView.layoutView(for: view) }
        return _layoutView
    }
    private var _layoutView: LayoutView!
    
    // MARK: - Access to created constraints
    
    /// Access the constraints created with this Layout instance
    public func constraints() -> [NSLayoutConstraint] {
        return newConstraints
    }
    
    // MARK: - Arranging convenience helpers
    
    /// Position the view below the bottom edge of another view
    @discardableResult
    public func below(_ other: UIView,
                      offset: CGFloat = 0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        make(LayoutYEdge.top, .equal, toItem: other.anchor(.bottom), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Position the view below the top edge of another view
    @discardableResult
    public func below(topOf other: UIView,
                      offset: CGFloat = 0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        make(LayoutYEdge.top, .equal, toItem: other.anchor(.top), constant: offset, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Position another view after this view.
    /// Returns the layout for the other view.
    @discardableResult
    public func followedBy(_ other: UIView,
                           offset: CGFloat = 0,
                           priority: LayoutPriority? = nil,
                           tag: Int? = nil,
                           active: Bool? = nil) -> Layout {
        return other.layout.below(view, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Position another view after this view.
    /// Returns the layout for the other view.
    @discardableResult
    public func followedBy(_ otherLayout: Layout,
                           offset: CGFloat = 0,
                           priority: LayoutPriority? = nil,
                           tag: Int? = nil,
                           active: Bool? = nil) -> Layout {
        return otherLayout.below(view, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Stack a bunch of views vertically (note the `view` member property isn't used)
    @discardableResult
    public func stack(_ views: UIView...,
                      space: CGFloat = 0,
                      below belowView: UIView? = nil,
                      offset: CGFloat = 0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        return stack(views, space: space, below: belowView, offset: offset, priority: priority, tag: tag, active: active)
    }
    
    /// Stack a bunch of views vertically (note the `view` member property isn't used)
    @discardableResult
    public func stack(_ views: [UIView],
                      space: CGFloat = 0,
                      below belowView: UIView? = nil,
                      offset: CGFloat = 0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        guard !views.isEmpty else { return self }
        
        if let belowView = belowView, let first = views.first {
            first.layout.below(belowView, offset: offset, priority: priority, tag: tag, active: active)
        }
        
        var previousView = views[0]
        for stackedView in views.suffix(from: 1) {
            stackedView.layout.below(previousView, offset: space, priority: priority, tag: tag, active: active)
            previousView = stackedView
        }
        
        return self
    }
}
