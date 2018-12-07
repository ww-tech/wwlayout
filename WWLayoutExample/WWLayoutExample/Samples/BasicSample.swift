//
//===----------------------------------------------------------------------===//
//
//  BasicSample.swift
//
//  Created by Steven Grosmark on 12/1/17.
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
import WWLayout

public class BasicSample : UIViewController {
    
    let insetView = UIView()
    let squareView = UIView()
    let circleView = UIView()
    let label = UILabel()
    let label2 = UILabel()
    let slider = UISlider()
    
    override public func viewDidLoad() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        insetView.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.98, alpha: 1.0)
        view.addSubview(insetView)
        
        squareView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        insetView.addSubview(squareView)
        
        circleView.backgroundColor = .white
        circleView.layer.cornerRadius = 30
        squareView.addSubview(circleView)
        
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Hello World!"
        label.textColor = .black
        
        insetView.addSubview(label)
        
        label2.numberOfLines = 0
        label2.text = """
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor \
                    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud \
                    exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    """
        label2.textColor = .black
        
        insetView.addSubview(label2)
        
        insetView.addSubview(slider)
    }

    private func setupConstraints() {
        
        // The safe area pre-iOS 11 will fall back to .superview left/right and the controller's top/bottom layout guides
        insetView.layout.fill(.safeArea, inset: 20)
        
        slider.layout
            .bottom(to: insetView, edge: .bottom, offset: -20) // sets the bottom of the slider
            .fill(insetView, axis: .x, inset: 20) // sets the left & right edges to view's edges, inset by 20pt
        
        squareView.layout
            .below(topOf: insetView, offset: 10)
            .center(in: insetView, axis: .x)
            .width(.equal, to: insetView.layout.width * 0.5 - 20, priority: .high)
            .width(.lessOrEqual, to: 500, priority: .required)
            .height(toWidth: 1.0)
        
        circleView.layout
            .center(in: squareView)
            .size(60)
        
        label.layout
            .center(in: insetView, axis: .x) // centers label horizontally in insetView
            .below(squareView, offset: 20) // sets top edge of label to bottom edge of headerView + 20pt
        
        label2.layout
            .fill(insetView, axis: .x, inset: 40)
            .height(180)
            .below(label, offset: 20)
    }
}
