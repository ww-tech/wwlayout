//
//===----------------------------------------------------------------------===//
//
//  SizeClass.swift
//
//  Created by Steven Grosmark on 6/27/19
//  Copyright © 2019 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2019 WW International, Inc.
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

/// Internal representation of the combination of horizontal and vertical UIUserInterfaceSizeClass values
internal enum SizeClass {
    
    case hcompact, hregular
    case hcompact_vcompact, hcompact_vregular
    case hregular_vcompact, hregular_vregular
    case vcompact, vregular
    
    init?(horizontal: UIUserInterfaceSizeClass?, vertical: UIUserInterfaceSizeClass?) {
        switch (horizontal, vertical) {
        case (.compact?, .compact?): self = .hcompact_vcompact
        case (.compact?, .regular?): self = .hcompact_vregular
        case (.regular?, .compact?): self = .hregular_vcompact
        case (.regular?, .regular?): self = .hregular_vregular
        case (.compact?, _): self = .hcompact
        case (.regular?, _): self = .hregular
        case (_, .compact?): self = .vcompact
        case (_, .regular?): self = .vregular
        default: return nil
        }
    }
    
    /// Retrieve the set of SizeClass values, that *this SizeClass.
    /// E.g., a constraint that is active for `.hcompact_vcompact`, is also active for `.hcompact` or `.vcompact`.
    func matches() -> Set<SizeClass> {
        switch self {
        case .hcompact_vcompact: return [.hcompact_vcompact, .hcompact, .vcompact]
        case .hcompact_vregular: return [.hcompact_vregular, .hcompact, .vregular]
        case .hregular_vcompact: return [.hregular_vcompact, .hregular, .vcompact]
        case .hregular_vregular: return [.hregular_vregular, .hregular, .vregular]
        case .hcompact, .hregular, .vcompact, .vregular: return [self]
        }
    }
    
}
