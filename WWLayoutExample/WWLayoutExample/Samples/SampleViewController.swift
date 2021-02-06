//
// ===----------------------------------------------------------------------===//
//
//  SampleViewController.swift
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

public class SampleViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func toggleNavigation() {
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(!navigationController.isNavigationBarHidden, animated: true)
        }
    }
    
    @objc func toggleTabBar() {
        if let tabBarController = tabBarController {
            tabBarController.tabBar.isHidden.toggle()
            if tabBarController.tabBar.isHidden {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                })
            }
            else {
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func goBack() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.popViewController(animated: true)
    }

}
