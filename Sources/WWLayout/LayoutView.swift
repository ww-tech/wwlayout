//
// ===----------------------------------------------------------------------===//
//
//  LayoutView.swift
//  WWLayout
//
//  Created by Steven Grosmark on 5/4/18.
//  Copyright © 2018 WW International, Inc. All rights reserved.
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

/// Hidden UIView that gets added to a UIViewController's hierarchy,
/// used to keep track of constraints that are tagged.
/// The hidden view is only created when constraints are tagged.
internal final class LayoutView: UIView {
    
    // MARK: - API
    
    /// Retrieve the LayoutView used to manage constraints created against a particular UIView
    internal static func layoutView(for view: UIView) -> LayoutView {
        let rootView = view.owningSuperview()
        for child in rootView.subviews {
            if let layoutView = child as? LayoutView {
                return layoutView
            }
        }
        let layoutView = LayoutView()
        rootView.insertSubview(layoutView, at: 0)
        return layoutView
    }
    
    /// Add a constraint to the list of managed constraints.
    /// A constraint is only added when it is tagged (i.e. constarint.tag != 0)
    internal func add(_ constraint: LayoutConstraint) {
        guard constraint.tag != 0 else { return }
        taggedConstraints[constraint.tag, default: []] += [WeakConstraintBox(constraint)]
    }
    
    internal func add(_ constraint: LayoutConstraint, sizeClass: SizeClass) {
        sizedConstraints[sizeClass, default: []] += [WeakConstraintBox(constraint)]
    }
    
    /// Get a list of constraints tagged with a specific tag
    internal func getConstraints(with tag: Int) -> [LayoutConstraint] {
        return taggedConstraints[tag, default:[]].compactMap { $0.constraint }
    }
    
    /// Activate / deactivate all constraints with a specific tag
    internal func setActive(_ active: Bool, tag: Int) {
        getConstraints(with: tag).setActive(active)
    }
    
    /// Activate / deactivate all constraints when switching from one size class to another.
    internal func switchSizeClass(from fromSizeClass: SizeClass?, to toSizeClass: SizeClass?) {
        let activate = toSizeClass?.matches() ?? []
        if let old = fromSizeClass {
            let deactivate = old.matches().subtracting(activate)
            for sizeClass in deactivate {
                sizedConstraints(sizeClass).setActive(false)
            }
        }
        for sizeClass in activate {
            sizedConstraints(sizeClass).setActive(true)
        }
    }
    
    // MARK: - Private implementation
    
    private struct WeakConstraintBox {
        weak var constraint: LayoutConstraint?
        
        init(_ constraint: LayoutConstraint) {
            self.constraint = constraint
        }
    }
    
    private var taggedConstraints = [Int: [WeakConstraintBox]]()
    private var sizedConstraints = [SizeClass: [WeakConstraintBox]]()
    
    private init() {
        super.init(frame: .zero)
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("unsupported") }
    
    private func sizedConstraints(_ sizeClass: SizeClass) -> [LayoutConstraint] {
        sizedConstraints[sizeClass, default: []].compactMap { $0.constraint }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let newSizeClass = SizeClass(horizontal: traitCollection.horizontalSizeClass,
                                     vertical: traitCollection.verticalSizeClass)
        let oldSizeClass = SizeClass(horizontal: previousTraitCollection?.horizontalSizeClass,
                                     vertical: previousTraitCollection?.verticalSizeClass)
        switchSizeClass(from: oldSizeClass, to: newSizeClass)
    }
}
