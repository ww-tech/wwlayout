//
// ===----------------------------------------------------------------------===//
//
//  ConstraintArrayTests.swift
//
//  Created by Steven Grosmark on 7/2/18.
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

class ConstraintArrayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ConstraintArrayHelpers() {
        // given
        let view = UIView()
        let constraints = view.layout.size(100, 200).newConstraints
        for constraint in constraints {
            XCTAssertTrue(constraint.isActive)
            XCTAssertEqual(constraint.tag, 0)
            XCTAssertEqual(constraint.priority, .required)
        }
        
        // when
        constraints.deactivate()
        
        // then
        for constraint in constraints {
            XCTAssertFalse(constraint.isActive)
        }
        
        // when
        constraints.activate()
        
        // then
        for constraint in constraints {
            XCTAssertTrue(constraint.isActive)
        }
        
        // when
        constraints.activate(with: .high)
        
        // then
        for constraint in constraints {
            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }
    
}
