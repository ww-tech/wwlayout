//
// ===----------------------------------------------------------------------===//
//
//  ViewController.swift
//  WWLayoutTV
//
//  Created by Steven Grosmark on 1/7/20.
//  Copyright © 2020 WW International. All rights reserved.
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        let matrixGreen = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        
        let label = UILabel()
        label.text = "Bonsoir, Elliot"
        label.font = UIFont.monospacedSystemFont(ofSize: 48, weight: .medium)
        label.textColor = matrixGreen
        
        view.addSubview(label)
        label.layout.center(in: .superview)
        
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitleColor(matrixGreen, for: .normal)
        button.setTitle("ⓘ", for: .normal)
        button.layer.cornerRadius = 11
        button.layer.masksToBounds = true
        
        view.addSubview(button)
        button.layout
            .centerX(to: .superview)
        .size(80)
            .bottom(to: .safeArea, offset: -30)
    }

}
