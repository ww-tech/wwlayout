//
//===----------------------------------------------------------------------===//
//
//  UITraitCollection+Active.swift
//  WWLayout
//
//  Created by Steven Grosmark on 5/6/18.
//  Copyright © 2018 WW International, Inc. All rights reserved.
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

extension UITraitCollection {
    
    internal func isActive(horizontalSize: UIUserInterfaceSizeClass?, verticalSize: UIUserInterfaceSizeClass?) -> Bool {
        return isActive(horizontalSize: horizontalSize) && isActive(verticalSize: verticalSize)
    }
    
    internal func isActive(horizontalSize: UIUserInterfaceSizeClass?) -> Bool {
        guard let hSize = horizontalSize else { return true }
        return hSize == .unspecified || horizontalSizeClass == hSize
    }
    
    internal func isActive(verticalSize: UIUserInterfaceSizeClass?) -> Bool {
        guard let vSize = verticalSize else { return true }
        return vSize == .unspecified || verticalSizeClass == vSize
    }
}
