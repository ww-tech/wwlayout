//
// ===----------------------------------------------------------------------===//
//
//  FillTests.swift
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

class FillTests: XCTestCase {
    
    private var container: UIView!
    private var child: UIView!

    override func setUp() {
        super.setUp()
        
        // given
        container = UIView()
        child = UIView()
        container.addSubview(child)
        container.layout.width(400)
    }

    override func tearDown() {
        child = nil
        container = nil
        
        super.tearDown()
    }

    func test_fillWidth_defaults() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, maximum: 200).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(child.frame.origin.x, 100)
        assertConstraints(constraints, priority: .required, active: true)
    }
    
    func test_fillWidth_left() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, maximum: 200, alignTo: .left).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(child.frame.origin.x, 0)
        assertConstraints(constraints, priority: .required, active: true)
    }
    
    func test_fillWidth_right() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, maximum: 200, alignTo: .right).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(child.frame.origin.x, 200)
        assertConstraints(constraints, priority: .required, active: true)
    }
    
    func test_fillWidth_insets() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, inset: 20, maximum: 400).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 360)
        XCTAssertEqual(child.frame.origin.x, 20)
        assertConstraints(constraints, priority: .required, active: true)
    }

    func test_fillWidth_uiEdgeInsets() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), maximum: 400).constraints()
        container.layoutIfNeeded()

        // then
        XCTAssertEqual(child.frame.size.width, 360)
        XCTAssertEqual(child.frame.origin.x, 20)
        assertConstraints(constraints, priority: .required, active: true)
    }
    
    func test_fillWidth_insetsIgnored() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, inset: 20, maximum: 200).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(child.frame.origin.x, 100)
        assertConstraints(constraints, priority: .required, active: true)
    }
    
    func test_fillWidth_tagged() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, maximum: 200, tag: 89).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(child.frame.origin.x, 100)
        assertConstraints(constraints, priority: .required, tag: 89, active: true)
    }
    
    func test_fillWidth_priority() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, maximum: 200, priority: .high).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(child.frame.origin.x, 100)
        assertConstraints(constraints, priority: .defaultHigh, active: true)
    }
    
    func test_fillWidth_inactive() {
        // when
        let constraints = child.layout.fillWidth(of: .superview, maximum: 200, active: false).constraints()
        container.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame.size.width, 0)
        XCTAssertEqual(child.frame.origin.x, 0)
        assertConstraints(constraints, priority: .required, active: false)
    }
    
    private func assertConstraints(_ constraints: [NSLayoutConstraint],
                                   priority expectedPriority: UILayoutPriority,
                                   tag: Int? = nil,
                                   active: Bool,
                                   function: String = #function) {
        let testPriority = expectedPriority.rawValue
        for constraint in constraints {
            XCTAssertEqual(constraint.isActive, active, function)
            let priority = constraint.priority.rawValue
            XCTAssertTrue(priority == testPriority || priority == testPriority - 1, function)
            
            let layoutConstraint = constraint as? LayoutConstraint
            XCTAssertNotNil(layoutConstraint, function)
            XCTAssertEqual(layoutConstraint?.tag, tag ?? 0, function)
        }
    }

}
