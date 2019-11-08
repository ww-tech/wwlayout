//
//===----------------------------------------------------------------------===//
//
//  TaggingSample.swift
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
 Sample that shows the use of tags to activate and deactivate constraints
 
 In portrait, there will be a square above some text.
 In landscape, there will be a square with text to the right.
 */
public class TaggingSample: UIViewController {
    
    let insetView = UIView()
    let boxView1 = UIView()
    let boxView2 = UIView()
    let button = UIButton()
    
    var toggle = true
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        insetView.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.98, alpha: 1.0)
        view.addSubview(insetView)
        
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Change", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        insetView.addSubview(button)
        
        boxView1.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.9, alpha: 0.25)
        insetView.addSubview(boxView1)
        
        boxView2.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.5, alpha: 0.25)
        insetView.addSubview(boxView2)
    }
    
    private func setupConstraints() {
        
        // The safe area pre-iOS 11 will fall back to .superview left/right and the controller's top/bottom layout guides
        insetView.layout.fill(.safeArea, inset: 20)
        
        button.layout
            .top(to: .superview)
            .fill(.superview, axis: .x)
        
        // common constraints
        boxView1.layout
            .left(to: .superview)
            .below(button, offset: 10)
        boxView2.layout
            .right(to: .superview)
            .bottom(to: .superview)
        
        // columns
        boxView1.layout(tag: 1, active: toggle)
            .left(to: .superview)
            .width(to: insetView.layout.width * 0.5)
            .bottom(to: .superview)
        boxView2.layout(tag: 1, active: toggle)
            .below(button, offset: 10)
            .width(to: insetView.layout.width * 0.5)
        
        // rows
        boxView1.layout(tag: 2, active: !toggle)
            .right(to: .superview)
        boxView2.layout(tag: 2, active: !toggle)
            .left(to: .superview)
            .top(to: boxView1, edge: .bottom)
            .height(to: boxView1)
    }
    
    @objc private func buttonTapped() {
        toggle.toggle()
        UIView.animate(withDuration: 0.3) {
            Layout.switchActiveConstraints(in: self.view, activeTag: self.toggle ? 1 : 2, deactiveTag: self.toggle ? 2 : 1)
            self.view.layoutIfNeeded()
        }
    }
}
