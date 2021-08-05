//
// ===----------------------------------------------------------------------===//
//
//  UIView+Containment.swift
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

extension UIView {
    
    /// Retrieve the UIViewController whose view hirearchy contains this view
    internal func owningViewController() -> UIViewController? {
        var responder: UIResponder = self
        while let parentResponder = responder.next {
            if let vc = parentResponder as? UIViewController {
                return vc
            }
            responder = parentResponder
        }
        return nil
    }
    
    /// Retrieve the UIView that is at the root of the view hierarchy that contains this view
    internal func owningSuperview() -> UIView {
        if let owningVC = owningViewController() {
            return owningVC.view
        }
        var rootView = self
        while let superview = rootView.superview, !(superview is UIWindow) {
            rootView = superview
        }
        return rootView
    }
    
}
