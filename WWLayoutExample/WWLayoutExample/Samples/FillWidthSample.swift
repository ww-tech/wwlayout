//
//===----------------------------------------------------------------------===//
//
//  FillWidthSample.swift
//
//  Created by Steven Grosmark on 9/7/18.
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

public class FillWidthSample: SampleViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let insetView = UIView()
        insetView.backgroundColor = .white
        view.addSubview(insetView)
        
        insetView.layout.fill(.safeArea)
        
        let maxScreenWidth = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let minScreenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let avgScreenWidth = round((minScreenWidth + maxScreenWidth) / 2)
        
        var previousView: UIView?
        func add(_ subview: UIView, maxWidth: CGFloat, alignTo edge: LayoutXEdge = .center) {
            insetView.addSubview(subview)
            if let previousView = previousView {
                subview.layout.top(to: previousView, edge: .bottom, offset: 10)
            }
            else {
                subview.layout.top(to: insetView)
            }
            subview.layout.fillWidth(of: insetView, inset: 10, maximum: maxWidth, alignTo: edge)
            previousView = subview
        }
        
        let label = UILabel()
        label.text = "Hint: rotate the device"
        label.textAlignment = .center
        add(label, maxWidth: minScreenWidth)
        
        func makeLabel(with text: String) -> UILabel {
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.darkGray.cgColor
            return label
        }
        let edges = [LayoutXEdge.left, .right, .center, .leading, .trailing]
        for edge in edges {
            let label = makeLabel(with: "Aligned to \(edge)")
            add(label, maxWidth: avgScreenWidth, alignTo: edge)
        }
        
        let multiLine = makeLabel(with: "Lorum absurdism ipso facto de jure. Veni vidi gustibus est. Pluribus omnibus tincture non gratis.")
        multiLine.numberOfLines = 0
        add(multiLine, maxWidth: avgScreenWidth)
    }
    
}
