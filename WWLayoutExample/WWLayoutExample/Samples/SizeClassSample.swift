//
//===----------------------------------------------------------------------===//
//
//  SizeClassSample.swift
//  WWLayoutExample
//
//  Created by Steven Grosmark on 5/4/18.
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
@testable import WWLayout

/**
 Sample that shows the use of size class to activate and deactivate constraints
 
 In portrait, there will be a square above some text.
 In landscape, there will be a square with text to the right.
 */
public class SizeClassSample: UIViewController {
    
    let insetView = UIView()
    let squareView = UIView()
    let label = UILabel()
    let hintLabel = UILabel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        insetView.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.98, alpha: 1.0)
        view.addSubview(insetView)
        
        squareView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        insetView.addSubview(squareView)
        
        label.numberOfLines = 0
        label.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor \
        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud \
        exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure \
        dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. \
        Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt \
        mollit anim id est laborum.
        """
        label.textColor = .black
        
        insetView.addSubview(label)
        
        hintLabel.numberOfLines = 0
        hintLabel.text = "rotate the device"
        hintLabel.textColor = .black
        hintLabel.textAlignment = .center
        squareView.addSubview(hintLabel)
    }
    
    private func setupConstraints() {
        
        // The safe area pre-iOS 11 will fall back to .superview left/right and the controller's top/bottom layout guides
        insetView.layout.fill(.safeArea, inset: 20)
        
        squareView.layout
            .below(topOf: insetView, offset: 10)
            .height(.lessOrEqual, to: insetView.layout.height - 20)
            .width(toHeight: 1.0)
            .size(260, priority: .required - 1)
        
        hintLabel.layout
            .fill(.superview, inset: 10)
        
        // phone portrait, all tablet
        squareView.layout(verticalSize: .regular)
            .center(in: insetView, axis: .x)
        
        label.layout(verticalSize: .regular)
            .fill(insetView, axis: .x, inset: 20)
            .below(squareView, offset: 20)
        
        // phone landscape
        squareView.layout(verticalSize: .compact)
            .leading(to: insetView, offset: 10)
        
        label.layout(verticalSize: .compact)
            .top(to: insetView, offset: 20)
            .leading(to: squareView, edge: .trailing, offset: 20)
            .trailing(to: insetView, offset: -20)
    }
}
