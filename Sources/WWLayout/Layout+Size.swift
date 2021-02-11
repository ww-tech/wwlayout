//
// ===----------------------------------------------------------------------===//
//
//  Layout+Size.swift
//
//  Created by Steven Grosmark on 12/10/17.
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
    
    //  size(80)
    //  size(80, 200)
    //  size(.lessOrEqual, to: 60)
    //  size(.lessOrEqual, to: 60, 100)
    //  size(to: view)
    
    /// Set the view's size to constant square value.
    @discardableResult
    public func size(_ length: CGFloat,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        size(.equal, to: length, length, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's size to constant square value.
    @discardableResult
    public func size(_ relation: LayoutRelation = .equal,
                     to length: CGFloat,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        return size(relation, to: length, length, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's size to constant values.
    @discardableResult
    public func size(_ width: CGFloat,
                     _ height: CGFloat,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        size(.equal, to: width, height, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's size to constant values.
    @discardableResult
    public func size(_ relation: LayoutRelation = .equal,
                     to width: CGFloat,
                     _ height: CGFloat,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.width, relation, to: width, priority: priority, tag: tag, active: active)
        make(LayoutDimensionEdge.height, relation, to: height, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's size relative to another view.
    @discardableResult
    public func size(_ relation: LayoutRelation = .equal,
                     to other: Anchorable,
                     multiplier: CGFloat = 1.0,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.width, relation, toItem: other.anchor(.width), multiplier: multiplier, priority: priority, tag: tag, active: active)
        make(LayoutDimensionEdge.height, relation, toItem: other.anchor(.height), multiplier: multiplier, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's size relative to a special set of anchors.
    @discardableResult
    public func size(_ relation: LayoutRelation = .equal,
                     to special: SpecialAnchorable,
                     multiplier: CGFloat = 1.0,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        return size(relation, to: special.anchorable(with: view), multiplier: multiplier, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's size to specified CGSize based on specified equality.
    @discardableResult
    public func size(_ relation: LayoutRelation = .equal,
                     to constraint: CGSize,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        size(relation, to: constraint.width, constraint.height, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's size to be equal to specified CGSize.
    @discardableResult
    public func size(_ constraint: CGSize,
                     priority: LayoutPriority? = nil,
                     tag: Int? = nil,
                     active: Bool? = nil) -> Layout {
        size(.equal, to: constraint.width, constraint.height, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's height to a constant value
    @discardableResult
    public func height(_ constant: CGFloat,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        return height(.equal, to: constant, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's height to a constant value
    @discardableResult
    public func height(_ relation: LayoutRelation = .equal,
                       to constant: CGFloat,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.height, relation, to: constant, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's height relative to another view's height
    @discardableResult
    public func height(_ relation: LayoutRelation = .equal,
                       to other: Anchorable,
                       multiplier: CGFloat = 1.0,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.height, relation, toItem: other.anchor(.height), multiplier: multiplier, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's height relative to another view's height
    @discardableResult
    public func height(_ relation: LayoutRelation = .equal,
                       to special: SpecialAnchorable,
                       multiplier: CGFloat = 1.0,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        return height(relation, to: special.anchorable(with: view), multiplier: multiplier, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's height relative to a dimension of another view
    @discardableResult
    public func height(_ relation: LayoutRelation = .equal,
                       to dimension: LayoutDimension,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.height, relation, to: dimension, priority: priority, tag: tag, active: active)
        return self
    }
    
    // MARK: - width
    
    /// Set the view's width to a constant value
    @discardableResult
    public func width(_ constant: CGFloat,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        return width(.equal, to: constant, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's width to a constant value
    @discardableResult
    public func width(_ relation: LayoutRelation = .equal,
                      to constant: CGFloat,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.width, relation, to: constant, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's width relative to another view's width
    @discardableResult
    public func width(_ relation: LayoutRelation = .equal,
                      to other: Anchorable,
                      multiplier: CGFloat = 1.0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.width, relation, toItem: other.anchor(.width), multiplier: multiplier, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's width relative to another view's width
    @discardableResult
    public func width(_ relation: LayoutRelation = .equal,
                      to special: SpecialAnchorable,
                      multiplier: CGFloat = 1.0,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        return width(relation, to: special.anchorable(with: view), multiplier: multiplier, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's width relative to a dimension of another view
    @discardableResult
    public func width(_ relation: LayoutRelation = .equal,
                      to dimension: LayoutDimension,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        make(LayoutDimensionEdge.width, relation, to: dimension, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's height relative to a view's width
    @discardableResult
    public func height(toWidth multiplier: CGFloat,
                       of other: UIView? = nil,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        return height(.equal, toWidth: multiplier, of: other, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's height relative to a view's width
    @discardableResult
    public func height(_ relation: LayoutRelation = .equal,
                       toWidth multiplier: CGFloat,
                       of other: UIView? = nil,
                       priority: LayoutPriority? = nil,
                       tag: Int? = nil,
                       active: Bool? = nil) -> Layout {
        let other = other ?? view
        make(LayoutDimensionEdge.height, relation, toItem: other.anchor(.width), multiplier: multiplier, priority: priority, tag: tag, active: active)
        return self
    }
    
    /// Set the view's width relative to a view's height
    @discardableResult
    public func width(toHeight multiplier: CGFloat,
                      of other: UIView? = nil,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        return width(.equal, toHeight: multiplier, of: other, priority: priority, tag: tag, active: active)
    }
    
    /// Set the view's width relative to a view's height
    @discardableResult
    public func width(_ relation: LayoutRelation = .equal,
                      toHeight multiplier: CGFloat,
                      of other: UIView? = nil,
                      priority: LayoutPriority? = nil,
                      tag: Int? = nil,
                      active: Bool? = nil) -> Layout {
        let other = other ?? view
        make(LayoutDimensionEdge.width, relation, toItem: other.anchor(.height), multiplier: multiplier, priority: priority, tag: tag, active: active)
        return self
    }
    
    // MARK: - Width and Height LayoutDimension
    
    /// The width LayoutDimension of a view's layout
    /// e.g.
    /// ```swift
    ///     someView.layout.width(to: otherView.layout.width * 1.25 + 10)
    /// ```
    public var width: InitialLayoutDimension { return InitialLayoutDimension(view, .width) }
    
    /// The height LayoutDimension of a view's layout
    /// e.g.
    /// ```swift
    ///     someView.layout.height(.greaterOrEqual, to: otherView.layout.height * 0.5)
    /// ```
    public var height: InitialLayoutDimension { return InitialLayoutDimension(view, .height) }
    
}
