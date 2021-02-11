//
// ===----------------------------------------------------------------------===//
//
//  SiblingTests.swift
//
//  Created by Steven Grosmark on 1/25/18.
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

class SiblingTests: XCTestCase {
    
    private var container: UIView!
    private var view1: UIView!
    private var view2: UIView!
    
    override func setUp() {
        super.setUp()
        container = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        if container.constraints.isEmpty {
            NSLayoutConstraint.activate([
                container.widthAnchor.constraint(equalToConstant: 400),
                container.heightAnchor.constraint(equalToConstant: 400)
                ])
        }
        
        view1 = UIView()
        view2 = UIView()
        view1.layout.size(200)
        view2.layout.size(200)
        container.addSubview(view1)
        container.addSubview(view2)
    }
    
    override func tearDown() {
        super.tearDown()
        container = nil
    }
    
    func testDiagonalArrangement() {
        view1.layout.top(to: .superview).left(to: .superview)
        view2.layout.top(to: view1, edge: .bottom).left(to: view1, edge: .right)
        
        container.layoutIfNeeded()
        
        XCTAssertEqual(view1.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
        XCTAssertEqual(view2.frame, CGRect(x: 200, y: 200, width: 200, height: 200))
    }
    
    func testCenterX() {
        view1.layout.top(to: .superview).center(in: .superview, axis: .x)
        view2.layout.top(to: view1, edge: .bottom).center(in: .superview, axis: .x)
        
        container.layoutIfNeeded()
        
        XCTAssertEqual(view1.frame, CGRect(x: 100, y: 0, width: 200, height: 200))
        XCTAssertEqual(view2.frame, CGRect(x: 100, y: 200, width: 200, height: 200))
    }
    
    func testCenterY() {
        view1.layout.left(to: .superview).center(in: .superview, axis: .y)
        view2.layout.left(to: view1, edge: .right).center(in: .superview, axis: .y)
        
        container.layoutIfNeeded()
        
        XCTAssertEqual(view1.frame, CGRect(x: 0, y: 100, width: 200, height: 200))
        XCTAssertEqual(view2.frame, CGRect(x: 200, y: 100, width: 200, height: 200))
    }
}
