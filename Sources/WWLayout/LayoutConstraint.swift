//
//===----------------------------------------------------------------------===//
//
//  LayoutConstraint.swift
//
//  Created by Steven Grosmark on 2/18/18.
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

/// A single constraint relationship
public class LayoutConstraint: NSLayoutConstraint {
    
    internal var tag: Int = 0
    
    /// Helper to set priority & activate an NSLayoutConstraint all at once
    @discardableResult
    internal func activate(with priority: LayoutPriority) -> LayoutConstraint {
        self.priority = UILayoutPriority(priority.rawValue)
        isActive = true
        return self
    }
    
    /// Helper to set priority & activate an NSLayoutConstraint all at once
    @discardableResult
    internal func set(priority: LayoutPriority, active: Bool) -> LayoutConstraint {
        self.priority = UILayoutPriority(rawValue: priority.rawValue)
        isActive = active
        return self
    }
    
    #if swift(>=4.2)
        public typealias Attribute = NSLayoutConstraint.Attribute
        public typealias Relation = NSLayoutConstraint.Relation
    #else
        public typealias Attribute = NSLayoutAttribute
        public typealias Relation = NSLayoutRelation
    #endif
}

extension Array where Element == LayoutConstraint {
    
    internal func activate(with priority: LayoutPriority) {
        self.forEach { $0.activate(with: priority) }
    }
    
    internal func activate() { self.setActive(true) }
    internal func deactivate() { self.setActive(false) }
    
    internal func setActive(_ active: Bool) {
        self.forEach { $0.isActive = active }
    }
    
}
