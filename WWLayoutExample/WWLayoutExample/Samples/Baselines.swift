//
//===----------------------------------------------------------------------===//
//
//  Baselines.swift
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

public class Baselines : SampleViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let insetView = UIView()
        view.addSubview(insetView)
        insetView.layout.fill(.safeArea, inset: 10)
        
        let letter = UILabel()
        letter.font = UIFont(name: "Arial", size: 64)
        letter.text = "L"
        insetView.addSubview(letter)
        
        let paragraph = UILabel()
        paragraph.font = UIFont(name: "Arial", size: 16)
        paragraph.numberOfLines = 0
        paragraph.text = "orem ipsum dolor sit amet, consectetur adipiscing elit. Donec consectetur lacus non dapibus lobortis. Nunc at elit a mauris mattis rutrum vel sit amet purus. Morbi at est non felis consequat fermentum. Duis accumsan non felis ut iaculis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque ornare velit lectus, id tincidunt lectus sodales nec. Nunc non lorem eget justo laoreet ornare quis non mi. Nunc facilisis arcu nec risus dignissim, a varius ligula pulvinar. Aliquam leo mauris, accumsan a sapien vel, congue lobortis velit."
        insetView.addSubview(paragraph)
        
        let byline = UILabel()
        byline.font = UIFont(name: "Arial", size: 32)
        byline.text = "- Anon"
        insetView.addSubview(byline)
        
        letter.setContentCompressionResistancePriority(.required, for: .horizontal)
        paragraph.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        byline.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        letter.setContentHuggingPriority(.required, for: .horizontal)
        byline.setContentHuggingPriority(.required, for: .horizontal)
        
        letter.layout
            .top(to: .superview)
            .left(to: .superview)
        
        paragraph.layout
            .firstBaseline(to: letter)
            .left(to: letter, edge: .right)
            .right(to: byline, edge: .left, offset: -10)
        
        byline.layout
            .firstBaseline(to: paragraph, edge: .lastBaseline)
            .right(to: .superview)
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
