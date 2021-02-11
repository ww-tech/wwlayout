//
// ===----------------------------------------------------------------------===//
//
//  StackingTests.swift
//
//  Created by Steven Grosmark on 11/7/19
//  Copyright © 2019 WW International, Inc.
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

class StackingBelowTests: XCTestCase {

    private var container: UIView!
    private var a: UIView!
    private var b: UIView!
    private var c: UIView!
    
    override func setUp() {
        super.setUp()
        container = UIView()
        a = UIView()
        b = UIView()
        c = UIView()
        container.addSubviews(a, b, c)
    }

    override func tearDown() {
        container = nil
        a = nil
        b = nil
        c = nil
        super.tearDown()
    }

    func test_below_noOffset() {
        // when
        a.layout.top(to: .superview).height(20)
        b.layout.below(a)
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(b.frame.origin.y, 20)
    }
    
    func test_below_withOffset() {
        // when
        a.layout.top(to: .superview).height(20)
        b.layout.below(a, offset: 10)
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(b.frame.origin.y, 30)
    }
    
    func test_followedBy_noOffset() {
        // when
        a.layout.top(to: .superview).height(20)
        b.layout
            .below(a)
            .height(20)
            .followedBy(c)
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(b.frame.origin.y, 20)
        XCTAssertEqual(c.frame.origin.y, 40)
    }
    
    func test_followedBy_withOffset() {
        // when
        a.layout.top(to: .superview).height(20)
        b.layout
            .below(a, offset: 10)
            .height(20)
            .followedBy(c, offset: 10)
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(b.frame.origin.y, 30)
        XCTAssertEqual(c.frame.origin.y, 60)
    }
    
    func test_stack_noSpace() {
        // when
        a.layout.top(to: .superview)
        [a, b, c].forEach { $0.layout.height(20) }
        container.layout.stack(a, b, c)
        container.layoutIfNeeded()
        Layout.describeConstraints(in: container)
        
        // then
        XCTAssertEqual(b.frame.origin.y, 20)
        XCTAssertEqual(c.frame.origin.y, 40)
    }
    
    func test_stack_withSpace() {
        // when
        a.layout.top(to: .superview)
        [a, b, c].forEach { $0.layout.height(20) }
        container.layout.stack(a, b, c, space: 10)
        container.layoutIfNeeded()
        Layout.describeConstraints(in: container)
        
        // then
        XCTAssertEqual(b.frame.origin.y, 30)
        XCTAssertEqual(c.frame.origin.y, 60)
    }
    
    func test_stack_withOffset() {
        // when
        a.layout.top(to: .superview)
        [a, b, c].forEach { $0.layout.height(20) }
        container.layout.stack(b, c, space: 10, below: a, offset: 100)
        container.layoutIfNeeded()
        Layout.describeConstraints(in: container)
        
        // then
        XCTAssertEqual(b.frame.origin.y, 120)
        XCTAssertEqual(c.frame.origin.y, 150)
    }

}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
    
}
