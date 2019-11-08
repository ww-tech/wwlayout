//
//===----------------------------------------------------------------------===//
//
//  CenterEdges.swift
//
//  Created by Steven Grosmark on 1/23/18.
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

public class CenterEdges: SampleViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //  |
        //  +-[---]
        //        |
        //    []-[ ]
        
        let insetView = view.addNewColorView(.black)
        insetView.layout.fill(.safeArea, inset: 10)
        
        let leftView = insetView.addNewColorView(.yellow)
        let dashView1 = insetView.addNewColorView(.white)
        let middleView = insetView.addNewColorView(.green)
        let dashView2 = insetView.addNewColorView(.white)
        let bottomView = insetView.addNewColorView(.blue)
        let dashView3 = insetView.addNewColorView(.white)
        let appendageView = insetView.addNewColorView(.red)
        
        leftView.layout
            .top(to: .superview, offset: 5)
            .left(to: .superview, offset: 5)
            .width(120)
            .height(to: insetView.layout.height * 0.3)
        
        dashView1.layout
            .size(10, 1)
            .centerY(to: leftView, edge: .bottom)
            .left(to: leftView, edge: .right, offset: 2)
        
        middleView.layout
            .centerY(to: dashView1)
            .left(to: dashView1, edge: .right, offset: 2)
            .right(to: dashView2, edge: .center)
            .height(80)
        
        dashView2.layout
            .size(1, 10)
            .centerX(to: bottomView)
            .top(to: middleView, edge: .bottom, offset: 2)
        
        bottomView.layout
            .top(to: dashView2, edge: .bottom, offset: 2)
            .bottom(to: .superview, offset: -5)
            .right(to: .superview, offset: -5)
            .width(120)
        
        dashView3.layout
            .size(10, 1)
            .centerY(to: bottomView)
            .right(to: bottomView, edge: .left, offset: -2)
        
        appendageView.layout
            .size(60, 60)
            .centerY(to: dashView3)
            .right(to: dashView3, edge: .left, offset: -2)
    }
    
}

extension UIView {
    fileprivate func addNewColorView(_ color: UIColor) -> UIView {
        let colorView = UIView()
        colorView.backgroundColor = color
        addSubview(colorView)
        return colorView
    }
}
