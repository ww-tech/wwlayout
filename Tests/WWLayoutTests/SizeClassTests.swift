//
//===----------------------------------------------------------------------===//
//
//  SizeClassTests.swift
//
//  Created by Steven Grosmark on 11/7/19
//  Copyright © 2019 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2019 WW International, Inc.
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

#if swift(>=4.2)
#else
extension UIViewController {
    func addChild(_ controller: UIViewController) {
        addChildViewController(controller)
    }
    
    func setOverrideTraitCollection(_ collection: UITraitCollection?, forChild controller: UIViewController) {
        setOverrideTraitCollection(collection, forChildViewController: controller)
    }
}
#endif

class SizeClassTests: XCTestCase {
    
    private var rootController: UIViewController!
    private var controller: UIViewController!
    private var child: UIView!

    override func setUp() {
        super.setUp()
        
        rootController = UIViewController()
        controller = UIViewController()
        child = UIView()
        rootController.addChild(controller)
        rootController.view.addSubview(controller.view)
        controller.view.addSubview(child)
    }

    override func tearDown() {
        child = nil
        controller = nil
        rootController = nil
        
        super.tearDown()
    }

    func test_SizeClass_construction() {
        let combinations: [(UIUserInterfaceSizeClass?, UIUserInterfaceSizeClass?, SizeClass?)] = [
            (.compact, .compact, .hcompact_vcompact),
            (.compact, .regular, .hcompact_vregular),
            (.regular, .compact, .hregular_vcompact),
            (.regular, .regular, .hregular_vregular),
            (.compact, nil, .hcompact),
            (.regular, nil, .hregular),
            (nil, .compact, .vcompact),
            (nil, .regular, .vregular),
            (nil, nil, nil)
        ]
        
        for (h, v, expected) in combinations {
            let sizeClass = SizeClass(horizontal: h, vertical: v)
            XCTAssertEqual(sizeClass, expected)
        }
    }
    
    func test_SizeClass_switchHorizontal() {
        // given
        override(horizontal: .compact, vertical: .regular)
        
        // when
        let regularConstraint = child.layout(horizontalSize: .regular).width(200).constraints().first
        let compactConstraint = child.layout(horizontalSize: .compact).width(300).constraints().first
        child.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.constraints.count, 1)
        XCTAssertEqual(child.frame.size.width, 300)
        XCTAssertEqual(regularConstraint?.isActive, false)
        XCTAssertEqual(compactConstraint?.isActive, true)
        
        // when
        override(horizontal: .regular, vertical: .regular)
        child.setNeedsLayout()
        child.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.constraints.count, 1)
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(regularConstraint?.isActive, true)
        XCTAssertEqual(compactConstraint?.isActive, false)
    }
    
    func test_SizeClass_switchVertical() {
        // given
        override(horizontal: .compact, vertical: .compact)
        
        // when
        let regularConstraint = child.layout(verticalSize: .regular).height(200).constraints().first
        let compactConstraint = child.layout(verticalSize: .compact).height(300).constraints().first
        child.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.constraints.count, 1)
        XCTAssertEqual(child.frame.size.height, 300)
        XCTAssertEqual(regularConstraint?.isActive, false)
        XCTAssertEqual(compactConstraint?.isActive, true)
        
        // when
        override(horizontal: .compact, vertical: .regular)
        child.setNeedsLayout()
        child.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.constraints.count, 1)
        XCTAssertEqual(child.frame.size.height, 200)
        XCTAssertEqual(regularConstraint?.isActive, true)
        XCTAssertEqual(compactConstraint?.isActive, false)
    }
    
    func test_SizeClass_switchBoth() {
        // given
        override(horizontal: .regular, vertical: .regular)
        
        // when
        let regularConstraints = child.layout.size(300, priority: .high).constraints()
        let compactConstraints = child.layout(horizontalSize: .compact, verticalSize: .compact).size(200).constraints()
        child.setNeedsLayout()
        child.layoutIfNeeded()
        Layout.describeConstraints(in: child)
        
        // then
        XCTAssertEqual(child.constraints.count, 2)
        XCTAssertEqual(child.frame.size.width, 300)
        XCTAssertEqual(child.frame.size.height, 300)
        XCTAssertAllEqual(regularConstraints.map { $0.isActive }, true) // always active
        XCTAssertAllEqual(compactConstraints.map { $0.isActive }, false)
        
        // when - override one to be compact
        override(horizontal: .compact, vertical: .regular)
        child.setNeedsLayout()
        child.layoutIfNeeded()
        
        // then - no change, both need to be compact to be applied
        XCTAssertEqual(child.constraints.count, 2)
        XCTAssertEqual(child.frame.size.width, 300)
        XCTAssertEqual(child.frame.size.height, 300)
        XCTAssertAllEqual(regularConstraints.map { $0.isActive }, true) // always active
        XCTAssertAllEqual(compactConstraints.map { $0.isActive }, false)
        
        // when
        override(horizontal: .compact, vertical: .compact)
        child.setNeedsLayout()
        child.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.constraints.count, 4)
        XCTAssertEqual(child.frame.size.width, 200)
        XCTAssertEqual(child.frame.size.height, 200)
        XCTAssertAllEqual(regularConstraints.map { $0.isActive }, true) // always active
        XCTAssertAllEqual(compactConstraints.map { $0.isActive }, true)
    }
    
    #if compiler(>=5.3)
    private func XCTAssertAllEqual<T: Equatable>(_ a: [T],
                                                 _ expected: T,
                                                 _ message: @autoclosure () -> String = "",
                                                 file: StaticString = #filePath,
                                                 line: UInt = #line) {
        for value in a {
            XCTAssertEqual(value, expected, message(), file: file, line: line)
        }
    }
    #else
    private func XCTAssertAllEqual<T: Equatable>(_ a: [T],
                                                 _ expected: T,
                                                 _ message: @autoclosure () -> String = "",
                                                 file: StaticString = #file,
                                                 line: UInt = #line) {
        for value in a {
            XCTAssertEqual(value, expected, message(), file: file, line: line)
        }
    }
    #endif
    
    private func override(horizontal: UIUserInterfaceSizeClass, vertical: UIUserInterfaceSizeClass) {
        let previous = controller.traitCollection
        rootController.setOverrideTraitCollection(
            UITraitCollection(traitsFrom: [
                UITraitCollection(horizontalSizeClass: horizontal),
                UITraitCollection(verticalSizeClass: vertical)
            ]),
            forChild: controller)
        let special = controller.view.subviews.first { $0 is LayoutView }
        special?.traitCollectionDidChange(previous)
    }

}
