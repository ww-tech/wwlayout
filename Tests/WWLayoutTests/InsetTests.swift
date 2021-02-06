//
// ===----------------------------------------------------------------------===//
//
//  InsetTests.swift
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

class InsetTests: XCTestCase {
    
    private var container: UIView!
    private var view: UIView!
    
    override func setUp() {
        super.setUp()
        container = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        if container.constraints.isEmpty {
            NSLayoutConstraint.activate([
                container.widthAnchor.constraint(equalToConstant: 400),
                container.heightAnchor.constraint(equalToConstant: 400)
                ])
        }
        
        view = UIView()
        container.addSubview(view)
    }
    
    override func tearDown() {
        super.tearDown()
        container = nil
        view = nil
    }
    
    func test_Insets_Construction() {
        do {
            let i1: Insets = 20
            let i2 = Insets(20, 20)
            let i3 = Insets(top: 20, left: 20, bottom: 20, right: 20)
            let i4 = Insets(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            XCTAssertEqual(i1, i2)
            XCTAssertEqual(i2, i3)
            XCTAssertEqual(i1, i3)
            XCTAssertEqual(i2, i4)
        }
        
        do {
            let i1: Insets = 123.5
            let i2 = Insets(123.5, 123.5)
            let i3 = Insets(top: 123.5, left: 123.5, bottom: 123.5, right: 123.5)
            let i4 = Insets(UIEdgeInsets(top: 123.5, left: 123.5, bottom: 123.5, right: 123.5))
            XCTAssertEqual(i1, i2)
            XCTAssertEqual(i2, i3)
            XCTAssertEqual(i1, i3)
            XCTAssertEqual(i2, i4)
        }
        
        do {
            let i1 = Insets(top: 10, left: 23, bottom: 37, right: 51)
            let i2 = Insets(UIEdgeInsets(top: 10, left: 23, bottom: 37, right: 51))
            XCTAssertEqual(i1, i2)
        }
    }
    
    func test_Insets_AppliedInset() {
        view.layout.fill(.superview, inset: 33)
        
        container.layoutIfNeeded()
        
        XCTAssertEqual(view.frame, container.frame.insetBy(dx: 33, dy: 33))
    }
    
    func test_Insets_AppliedMixedInset() {
        view.layout.fill(.superview, inset: Insets(33, 51))
        
        container.layoutIfNeeded()
        
        XCTAssertEqual(view.frame, container.frame.insetBy(dx: 33, dy: 51))
    }
    
    func test_Insets_AppliedOutset() {
        view.layout.fill(.superview, inset: -11)
        
        container.layoutIfNeeded()
        
        XCTAssertEqual(view.frame, container.frame.insetBy(dx: -11, dy: -11))
    }
    
    func test_Insets_AppliedMixedInOutset() {
        let edgeInsets = UIEdgeInsets(top: 11, left: -22, bottom: 33, right: -44)
        view.layout.fill(.superview, inset: Insets(edgeInsets))
        
        container.layoutIfNeeded()
        
        var frame = container.frame
        frame.origin.y += edgeInsets.top
        frame.origin.x += edgeInsets.left
        frame.size.width -= edgeInsets.left + edgeInsets.right
        frame.size.height -= edgeInsets.top + edgeInsets.bottom
        XCTAssertEqual(view.frame, frame)
    }
    
}
