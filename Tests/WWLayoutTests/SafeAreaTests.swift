//
// ===----------------------------------------------------------------------===//
//
//  SafeAreaTests.swift
//
//  Created by Steven Grosmark on 3/26/18.
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

import XCTest
@testable import WWLayout

class SafeAreaTests: XCTestCase {
    
    private var controller: UIViewController!
    
    override func setUp() {
        super.setUp()
        controller = UIViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        controller = nil
    }
    
    func testSafeArea() {
        let subview = UIView()
        let centered = UIView()
        controller.view.addSubview(subview)
        controller.view.addSubview(centered)
        controller.beginAppearanceTransition(true, animated: true)
        
        XCTAssertEqual(subview.layout.fill(.safeArea).constraints().count, 4)
        XCTAssertEqual(centered.layout.center(in: .safeArea).size(200).constraints().count, 4)
    }
    
    func testEmulatedSafeArea() {
        let subview = UIView()
        let centered = UIView()
        controller.view.addSubview(subview)
        controller.view.addSubview(centered)
        controller.beginAppearanceTransition(true, animated: true)
        
        XCTAssertEqual(subview.layout.fill(EmulatedSafeAreaAnchorable(for: controller.view)).constraints().count, 4)
        
        let special = EmulatedSafeAreaAnchorable(for: controller.view)
        XCTAssertEqual(centered.layout.center(in: special).size(200).constraints().count, 4)
    }
    
}
