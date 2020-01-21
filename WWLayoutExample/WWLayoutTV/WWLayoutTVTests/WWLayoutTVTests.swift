//
//  WWLayoutTVTests.swift
//  WWLayoutTVTests
//
//  Created by Steven Grosmark on 1/7/20.
//  Copyright © 2020 WW International. All rights reserved.
//

import XCTest
import WWLayout
@testable import WWLayoutTV

class WWLayoutTVTests: XCTestCase {

    /// Simple test to make sure WWLayout is properly added to project
    func testExample() {
        // given
        let parent = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        let child = UIView()
        
        parent.addSubview(child)
        
        // when
        child.layout
            .size(200, 100)
            .center(in: .superview)
        parent.layoutIfNeeded()
        
        // then
        XCTAssertEqual(child.frame, CGRect(x: 100, y: 150, width: 200, height: 100))
    }

}
