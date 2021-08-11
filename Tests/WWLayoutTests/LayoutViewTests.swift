//
// ===----------------------------------------------------------------------===//
//
//  LayoutViewTests.swift
//
//  Created by Steven Grosmark on 08/10/2021
//  Copyright © 2021 WW International, Inc.
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

class LayoutViewTests: XCTestCase {

    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        window.rootViewController = UIViewController()
    }
    
    override func tearDown() {
        window = nil
        
        super.tearDown()
    }
    
    func test_creationInViewController() throws {
        // given
        let label = UILabel()
        window.rootViewController?.view.addSubview(label)
        
        // when
        label.layout(horizontalSize: .compact).fill(.superview)
        
        // then
        let layoutView = findLayoutView()
        XCTAssertNotNil(layoutView, "LayoutView should exist")
        XCTAssert(layoutView?.superview === window.rootViewController?.view, "LayoutView should be created at root of the view controller" )
    }
    
    func test_creationInViewController_nestedViews() throws {
        // given
        let label = UILabel()
        window.rootViewController?.view.addSubview(UIView(subviews: UIView(subviews: label)))
        
        // when
        label.layout(horizontalSize: .compact).fill(.superview)
        
        // then
        let layoutView = findLayoutView()
        XCTAssertNotNil(layoutView, "LayoutView should exist")
        XCTAssert(layoutView?.superview === window.rootViewController?.view, "LayoutView should be created at root of the view controller" )
    }
    
    func test_creationInViewController_nestedController() throws {
        // given
        let childController = UIViewController()
        let label = UILabel()
        
        childController.view.addSubview(UIView(subviews: UIView(subviews: label)))
        window.rootViewController?.addChild(childController)
        window.rootViewController?.view.addSubview(childController.view)
        
        // when
        label.layout(horizontalSize: .compact).fill(.superview)
        
        // then
        let layoutView = findLayoutView()
        XCTAssertNotNil(layoutView, "LayoutView should exist")
        XCTAssert(layoutView?.superview === childController.view, "LayoutView should be created at root of the _child_ view controller" )
    }
    
    func test_creationInWindow() throws {
        // given
        let label = UILabel()
        let targetSubview = UIView(subviews: UIView(subviews: label))
        window.addSubview(targetSubview)
        
        // when
        label.layout(horizontalSize: .compact).fill(.superview)
        
        // then
        let layoutView = findLayoutView()
        XCTAssertNotNil(layoutView, "LayoutView should exist")
        XCTAssert(layoutView?.superview === targetSubview, "LayoutView should be created in child of thw window" )
    }
    
    private func findLayoutView() -> LayoutView? {
        var toCheck: [UIView] = [window, window.rootViewController?.view].compactMap { return $0 }
        while !toCheck.isEmpty {
            let candidate = toCheck.removeFirst()
            if let layoutView = candidate as? LayoutView {
                return layoutView
            }
            toCheck.append(contentsOf: candidate.subviews)
        }
        return nil
    }

}
