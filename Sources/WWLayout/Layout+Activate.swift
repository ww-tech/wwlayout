//
//===----------------------------------------------------------------------===//
//
//  Layout+Activate.swift
//
//  Created by Steven Grosmark on 5/4/18.
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
    
    /// Find all the constraints matching `tag`  in the view hierarchy that contains `view`
    /// - Parameters:
    ///   - view: one of the views in the target view hierarchy
    ///   - tag: the tag to search for
    public static func findConstraints(in view: UIView, tag: Int) -> [NSLayoutConstraint] {
        guard tag != 0 && tag != Int.min else { return [] }
        let layoutView = LayoutView.layoutView(for: view)
        return layoutView.getConstraints(with: tag)
    }
    
    /// Activate all constraints matching `tag`  in the view hierarchy that contains `view`
    /// - Parameters:
    ///   - view: one of the views in the target view hierarchy
    ///   - tag: the tag to search for
    public static func activateConstraints(in view: UIView, tag: Int) {
        guard tag != 0 && tag != Int.min else { return }
        switchActiveConstraints(in: view, activeTag: tag)
    }
    
    /// Deactivate all constraints matching `tag`  in the view hierarchy that contains `view`
    /// - Parameters:
    ///   - view: one of the views in the target view hierarchy
    ///   - tag: the tag to search for
    public static func deactivateConstraints(in view: UIView, tag: Int) {
        guard tag != 0 && tag != Int.min else { return }
        switchActiveConstraints(in: view, deactiveTag: tag)
    }
    
    /// Activate and/or deactivate all constraints matching the specified tags in the view hierarchy that contains `view`
    /// - Parameters:
    ///   - view: one of the views in the target view hierarchy
    ///   - activeTag: constraints with this tag will be activated (default is nil)
    ///   - deactiveTag: constraints with this tag will be deactivated (default is nil)
    public static func switchActiveConstraints(in view: UIView,
                                               activeTag: Int? = nil,
                                               deactiveTag: Int? = nil) {
        guard activeTag != deactiveTag else { return }
        let layoutView = LayoutView.layoutView(for: view)
        if let deactiveTag = deactiveTag { layoutView.setActive(false, tag: deactiveTag) }
        if let activeTag = activeTag { layoutView.setActive(true, tag: activeTag) }
    }
    
    internal static func describeConstraints(in view: UIView) {
        var rootView = view
        while let superview = rootView.superview { rootView = superview }
        describeConstraints(in: rootView, indent: 0)
    }
    
    internal static func describeConstraints(in view: UIView, indent: Int) {
        let space = String(repeating: "   ", count: indent)
        print("\(space)\(view)")
        view.constraints.lazy
            .compactMap { $0 as? LayoutConstraint }
            .forEach { constraint in
                print("\(space) tag=\(constraint.tag) \(constraint)")
        }
        view.subviews.forEach { describeConstraints(in: $0, indent: indent + 1) }
    }
}
