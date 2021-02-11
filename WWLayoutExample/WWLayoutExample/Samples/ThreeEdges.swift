//
// ===----------------------------------------------------------------------===//
//
//  ThreeEdges.swift
//
//  Created by Steven Grosmark on 1/19/18.
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
import WWLayout

public class ThreeEdges: SampleViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let insetView = UIView()
        insetView.backgroundColor = .black
        view.addSubview(insetView)
        
        insetView.layout.fill(.safeArea)
        
        let exclusions: [LayoutFillEdge] = [.left, .top, .right, .bottom]
        var lastView: UIView = insetView
        exclusions.forEach { edge in
            let subview = UIView()
            subview.backgroundColor = UIColor(red: .random(min: 0.5), green: .random(min: 0.5), blue: .random(min: 0.5), alpha: 0.5)
            insetView.addSubview(subview)
            subview.layout.fill(lastView, except: edge, inset: 10)
            switch edge {
            case .left, .right: subview.layout.width(to: lastView.layout.width * 0.75)
            case .top, .bottom: subview.layout.height(to: lastView.layout.height * 0.75)
            }
            lastView = subview
        }
    }
    
}

extension CGFloat {
    static func random(min: CGFloat = 0.0, max: CGFloat = 1.0) -> CGFloat {
        #if swift(>=5)
            return .random(in: min..<max)
        #else
            // swiftlint:disable legacy_random
            return min + (max - min) * CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX)
        #endif
    }
}
