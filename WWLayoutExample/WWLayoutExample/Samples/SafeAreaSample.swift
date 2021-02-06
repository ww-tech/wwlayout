//
// ===----------------------------------------------------------------------===//
//
//  SafeAreaSample.swift
//
//  Created by Steven Grosmark on 12/1/17.
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

public class SafeAreaSample: SampleViewController {
    
    let insetView = UIView()
    let label = UILabel()
    let backButton = UIButton()
    let navigationButton = UIButton()
    let tabsButton = UIButton()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        insetView.backgroundColor = .gray
        view.addSubview(insetView)
        
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Gray rectangle is 10pt inside the safe area"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        
        insetView.addSubview(label)
        
        navigationButton.setTitle("Toggle Navigation", for: .normal)
        navigationButton.addTarget(self, action: #selector(toggleNavigation), for: .touchUpInside)
        insetView.addSubview(navigationButton)
        
        backButton.setTitle("Back to Samples", for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        insetView.addSubview(backButton)
        
        tabsButton.setTitle("Toggle Tab Bar", for: .normal)
        tabsButton.addTarget(self, action: #selector(toggleTabBar), for: .touchUpInside)
        insetView.addSubview(tabsButton)
    }
    
    private func setupConstraints() {
        insetView.layout.fill(.safeArea, inset: 10)
        navigationButton.layout
            .top(to: insetView)
            .center(in: insetView, axis: .x)
        label.layout
            .fill(insetView, axis: .x, inset: 20)
            .center(in: insetView, axis: .y)
        backButton.layout
            .below(label)
            .center(in: insetView, axis: .x)
        tabsButton.layout
            .bottom(to: insetView)
            .center(in: insetView, axis: .x)
    }
}
