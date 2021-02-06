//
// ===----------------------------------------------------------------------===//
//
//  LayoutRelation.swift
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

/// Constraint equality relationship
public enum LayoutRelation {
    case equal
    case lessOrEqual
    case greaterOrEqual
}

// MARK: - constraint creation helpers

extension LayoutRelation {
    
    /// Get the corresponding NSLayoutRelation
    internal var nsRelation: LayoutConstraint.Relation {
        switch self {
        case .equal: return .equal
        case .lessOrEqual: return .lessThanOrEqual
        case .greaterOrEqual: return .greaterThanOrEqual
        }
    }
}
