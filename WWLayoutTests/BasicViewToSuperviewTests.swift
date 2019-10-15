//
//===----------------------------------------------------------------------===//
//
//  BasicViewToSuperviewTests.swift
//
//  Created by Steven Grosmark on 12/1/17.
//  Copyright © 2018 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2018 WW International, Inc.
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
//===----------------------------------------------------------------------===//
//

import XCTest
@testable import WWLayout

class BasicViewToSuperviewTests: XCTestCase {
    
    private var container: UIView!
    
    override func setUp() {
        super.setUp()
        container = UIView()
    }
    
    override func tearDown() {
        super.tearDown()
        container = nil
    }
    
    func testConstraintCounts() {
        let subview = UIView()
        container.addSubview(subview)
        
        XCTAssertEqual(subview.layout.fill(.superview).constraints().count, 4)
        checkConstraintCount("fill view", 4) { return $0.layout.fill(container) }
        checkConstraintCount("fill x of superview", 2) { return $0.layout.fill(.superview, axis: .x) }
        checkConstraintCount("fill y of superview", 2) { return $0.layout.fill(.superview, axis: .y) }
        checkConstraintCount("fill superview, not .top", 3) { return $0.layout.fill(.superview, except: .top) }
        checkConstraintCount("fill superview, not .bottom", 3) { return $0.layout.fill(.superview, except: .bottom) }
        checkConstraintCount("fill superview, not .left", 3) { return $0.layout.fill(.superview, except: .left) }
        checkConstraintCount("fill superview, not .right", 3) { return $0.layout.fill(.superview, except: .right) }
        
        checkConstraintCount("center in superview", 2) { return $0.layout.center(in: .superview) }
        checkConstraintCount("center x in superview", 1) { return $0.layout.center(in: .superview, axis: .x) }
        checkConstraintCount("center y in superview", 1) { return $0.layout.center(in: .superview, axis: .y) }
        
        checkConstraintCount("left to view", 1) { return $0.layout.left(to: container) }
        checkConstraintCount("left to .superview", 1) { return $0.layout.left(to: .superview, offset: 10) }
        checkConstraintCount("right to .superview", 1) { return $0.layout.right(to: .superview) }
        checkConstraintCount("leading to .superview", 1) { return $0.layout.leading(to: .superview) }
        checkConstraintCount("trailing to .superview", 1) { return $0.layout.trailing(to: .superview) }
        checkConstraintCount("centerX to .superview", 1) { return $0.layout.centerX(to: .superview) }
        
        checkConstraintCount("top to .superview", 1) { return $0.layout.top(to: .superview) }
        checkConstraintCount("bottom to .superview", 1) { return $0.layout.bottom(to: .superview) }
        checkConstraintCount("firstBaseline to .superview", 1) { return $0.layout.firstBaseline(to: .superview) }
        checkConstraintCount("lastBaseline to .superview", 1) { return $0.layout.lastBaseline(to: .superview) }
        checkConstraintCount("centerY to .superview", 1) { return $0.layout.centerY(to: .superview) }
        
        checkConstraintCount("width to superview", 1) { return $0.layout.width(to: .superview) }
        checkConstraintCount("width to container", 1) { return $0.layout.width(to: container) }
        
        checkConstraintCount("height to superview", 1) { return $0.layout.height(to: .superview) }
        checkConstraintCount("height to container", 1) { return $0.layout.height(to: container) }
        
        checkConstraintCount("size to superview", 2) { return $0.layout.size(to: .superview) }
        checkConstraintCount("size to container", 2) { return $0.layout.size(to: container) }
        
        checkConstraintCount("width as a constant", 1) { return $0.layout.width(200) }
        checkConstraintCount("height as a constant", 1) { return $0.layout.width(200) }
        checkConstraintCount("size as a constant", 2) { return $0.layout.size(200) }
        
        checkConstraintCount("height to width", 1) { return $0.layout.height(toWidth: 0.5) }
        checkConstraintCount("width to height", 1) { return $0.layout.width(toHeight: 0.5) }
    }
    
    private func checkConstraintCount(_ description: String, _ expected: Int, makeConstraints: (UIView) -> Layout) {
        let subview = UIView()
        container.addSubview(subview)
        
        let resultCount = makeConstraints(subview).constraints().count
        
        XCTAssertEqual(resultCount, expected, "\(description) failed - expected \(expected), found \(resultCount)")
    }
    
    func testParentConstraintCounts() {
        checkParentConstraintCount("fill view", 4) { $0.layout.fill(container) }
        checkParentConstraintCount("fill x of superview", 2) { $0.layout.fill(.superview, axis: .x) }
        checkParentConstraintCount("fill y of superview", 2) { $0.layout.fill(.superview, axis: .y) }
        checkParentConstraintCount("fill superview, not .bottom", 3) { $0.layout.fill(.superview, except: .bottom) }
        
        checkParentConstraintCount("center in superview", 2) { $0.layout.center(in: .superview) }
        checkParentConstraintCount("center x in superview", 1) { $0.layout.center(in: .superview, axis: .x) }
        checkParentConstraintCount("center y in superview", 1) { $0.layout.center(in: .superview, axis: .y) }
        
        checkParentConstraintCount("left to view", 1) { $0.layout.left(to: container) }
        checkParentConstraintCount("left to .superview", 1) { $0.layout.left(to: .superview, offset: 10) }
        checkParentConstraintCount("right to .superview", 1) { $0.layout.right(to: .superview) }
        checkParentConstraintCount("leading to .superview", 1) { $0.layout.leading(to: .superview) }
        checkParentConstraintCount("trailing to .superview", 1) { $0.layout.trailing(to: .superview) }
        checkParentConstraintCount("centerX to .superview", 1) { $0.layout.centerX(to: .superview) }
        
        checkParentConstraintCount("top to .superview", 1) { $0.layout.top(to: .superview) }
        checkParentConstraintCount("bottom to .superview", 1) { $0.layout.bottom(to: .superview) }
        checkParentConstraintCount("firstBaseline to .superview", 1) { $0.layout.firstBaseline(to: .superview) }
        checkParentConstraintCount("lastBaseline to .superview", 1) { $0.layout.lastBaseline(to: .superview) }
        checkParentConstraintCount("centerY to .superview", 1) { $0.layout.centerY(to: .superview) }
        
        checkParentConstraintCount("width to superview", 1) { $0.layout.width(to: .superview) }
        checkParentConstraintCount("width to container", 1) { $0.layout.width(to: container) }
        
        checkParentConstraintCount("height to superview", 1) { $0.layout.height(to: .superview) }
        checkParentConstraintCount("height to container", 1) { $0.layout.height(to: container) }
        
        checkParentConstraintCount("size to superview", 2) { $0.layout.size(to: .superview) }
        checkParentConstraintCount("size to container", 2) { $0.layout.size(to: container) }
    }
    
    private func checkParentConstraintCount(_ description: String, _ expected: Int, makeConstraints: (UIView) -> Void) {
        let subview = UIView()
        container.addSubview(subview)
        
        makeConstraints(subview)
        
        XCTAssertEqual(container.constraints.count, expected, "\(description) failed - expected \(expected), found \(container.constraints.count)")
        
        subview.removeFromSuperview()
        
        XCTAssertEqual(container.constraints.count, 0)
    }
    
    func testSizeConstraints() {
        
        checkConstrainedSize("width is a constant", width: 200) { $0.layout.width(200) }
        checkConstrainedSize("height is a constant", width: 200) { $0.layout.width(200) }
        checkConstrainedSize("width matches parent", width: 400) { $0.layout.width(to: .superview) }
        checkConstrainedSize("height matches parent", height: 400) { $0.layout.height(to: .superview) }
        
        checkConstrainedSize("width to container * .5", width: 200) { $0.layout.width(to: container.layout.width * 0.5) }
        checkConstrainedSize("width to container * .5", width: 200) { $0.layout.width(to: container, multiplier: 0.5) }
        checkConstrainedSize("width to superview * .5", width: 200) { $0.layout.width(to: .superview, multiplier: 0.5) }
        checkConstrainedSize("width to container * .5 + 30", width: 230) { $0.layout.width(to: container.layout.width * 0.5 + 30) }
        checkConstrainedSize("width to container * .75 - 50", width: 250) { $0.layout.width(to: container.layout.width * 0.75 - 50) }
        checkConstrainedSize("width to container.height * .5", width: 200) { $0.layout.width(to: container.layout.height * 0.5) }
        checkConstrainedSize("width to container.height * .5 + 30", width: 230) { $0.layout.width(to: container.layout.height * 0.5 + 30) }
        checkConstrainedSize("width to container.height * .75 - 50", width: 250) { $0.layout.width(to: container.layout.height * 0.75 - 50) }
        
        checkConstrainedSize("height to container * .5", height: 200) { $0.layout.height(to: container.layout.height * 0.5) }
        checkConstrainedSize("height to container * .5", height: 200) { $0.layout.height(to: container, multiplier: 0.5) }
        checkConstrainedSize("height to superview * .5", height: 200) { $0.layout.height(to: .superview, multiplier: 0.5) }
        checkConstrainedSize("height to container * .5 + 30", height: 230) { $0.layout.height(to: container.layout.height * 0.5 + 30) }
        checkConstrainedSize("height to container * .75 - 50", height: 250) { $0.layout.height(to: container.layout.height * 0.75 - 50) }
        checkConstrainedSize("height to container.width * .5", height: 200) { $0.layout.height(to: container.layout.width * 0.5) }
        checkConstrainedSize("height to container.width * .5 + 30", height: 230) { $0.layout.height(to: container.layout.width * 0.5 + 30) }
        checkConstrainedSize("height to container.width * .75 - 50", height: 250) { $0.layout.height(to: container.layout.width * 0.75 - 50) }
        
        checkConstrainedSize("size to constant", width: 300, height: 300) { $0.layout.size(300) }
        checkConstrainedSize("size to constant", width: 200, height: 300) { $0.layout.size(200, 300) }
        checkConstrainedSize("size to superview", width: 400, height: 400) { $0.layout.size(to: .superview) }
        checkConstrainedSize("size to container", width: 400, height: 400) { $0.layout.size(to: container) }
        checkConstrainedSize("size to container * .5", width: 200, height: 200) { $0.layout.size(to: container, multiplier: 0.5) }
        
        checkConstrainedSize("size to CGSize", width: 200, height: 200) { $0.layout.size(.equal, CGSize(width: 200, height: 200)) }
    }
    
    private func checkConstrainedSize(_ descroiption: String, width: CGFloat? = nil, height: CGFloat? = nil, makeConstraints: (UIView) -> Void) {
        let subview = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        if container.constraints.isEmpty {
            NSLayoutConstraint.activate([
                container.widthAnchor.constraint(equalToConstant: 400),
                container.heightAnchor.constraint(equalToConstant: 400)
            ])
        }
        container.addSubview(subview)
        
        makeConstraints(subview)
        
        container.setNeedsLayout()
        container.layoutIfNeeded()
        
        if let width = width {
            XCTAssertEqual(subview.frame.width, width, "\(description) failed - expected width \(width), found \(subview.frame.width)")
        }
        if let height = height {
            XCTAssertEqual(subview.frame.height, height, "\(description) failed - expected height \(height), found \(subview.frame.height)")
        }
        
        subview.removeFromSuperview()
    }
}
