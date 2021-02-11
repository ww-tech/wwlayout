//
// ===----------------------------------------------------------------------===//
//
//  PriorityTests.swift
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

class PriorityTests: XCTestCase {
    
    private var container: UIView!
    
    override func setUp() {
        super.setUp()
        container = UIView()
    }
    
    override func tearDown() {
        super.tearDown()
        container = nil
    }
    
    func testPriorities() {
        let subview = UIView()
        container.addSubview(subview)
        
        // default required priority
        for constraint in subview.layout.size(200).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority.required)
        }
        
        // our version of required
        for constraint in subview.layout.size(200, priority: .required).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority.required)
        }
        
        // our version of high
        for constraint in subview.layout.fill(.superview, priority: .high).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority.defaultHigh)
        }
        
        // our version of low, as the default
        for constraint in subview.layout(priority: .low).center(in: .superview).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority.defaultLow)
        }
        
        // set a different default, override it
        let constraints = subview.layout(priority: .low)
            .left(to: .superview)
            .top(to: .superview, priority: .high)
            .right(to: .superview)
            .constraints()
        
        XCTAssertEqual(constraints[0].priority, UILayoutPriority.defaultLow)
        XCTAssertEqual(constraints[1].priority, UILayoutPriority.defaultHigh)
        XCTAssertEqual(constraints[2].priority, UILayoutPriority.defaultLow)
    }
    
    func testIntLiterals() {
        let subview = UIView()
        container.addSubview(subview)
        
        for constraint in subview.layout.fill(.superview, priority: 678).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority(678))
        }
        
        for constraint in subview.layout(priority: 789).center(in: .superview).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority(789))
        }
    }
    
    func testFloatLiterals() {
        let subview = UIView()
        container.addSubview(subview)
        
        for constraint in subview.layout.fill(.superview, priority: 123.4).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority(123.4))
        }
        
        for constraint in subview.layout(priority: 567.8).center(in: .superview).constraints() {
            XCTAssertEqual(constraint.priority, UILayoutPriority(567.8))
        }
    }
    
    func testAdditionSubtraction() {
        // + operator
        XCTAssertEqual((LayoutPriority.high + 2).rawValue, LayoutPriority.high.rawValue + 2)
        XCTAssertEqual((LayoutPriority.low + 1.7).rawValue, LayoutPriority.low.rawValue + 1.7)
        XCTAssertEqual((LayoutPriority.required + 1).rawValue, LayoutPriority.required.rawValue)
        
        // - operator
        XCTAssertEqual((LayoutPriority.low - 5).rawValue, LayoutPriority.low.rawValue - 5)
        XCTAssertEqual((LayoutPriority.required - 3.14).rawValue, LayoutPriority.required.rawValue - 3.14)
        XCTAssertEqual((LayoutPriority.low - 999).rawValue, 0)
        
        // +=
        var priority: LayoutPriority = .high
        var value = priority.rawValue
        
        priority += 1
        value += 1
        XCTAssertEqual(priority.rawValue, value)
        
        priority += 12.8
        value += 12.8
        XCTAssertEqual(priority.rawValue, value)
        
        // -=
        priority -= 1
        value -= 1
        XCTAssertEqual(priority.rawValue, value)
        
        priority -= 2.5
        value -= 2.5
        XCTAssertEqual(priority.rawValue, value)
        
        // test with a view
        let subview = UIView()
        container.addSubview(subview)
        
        for constraint in subview.layout.size(200, priority: .required - 1).constraints() {
            XCTAssertEqual(constraint.priority.rawValue, UILayoutPriority.required.rawValue - 1)
        }
    }
    
    func testEquatable() {
        XCTAssertEqual(LayoutPriority.required, 1000.0)
        XCTAssertEqual(LayoutPriority.high, 750)
        XCTAssertEqual(LayoutPriority.low, 250)
        
        let priority: LayoutPriority = .low - 1
        XCTAssertEqual(priority, LayoutPriority(rawValue: 249))
    }
    
}
