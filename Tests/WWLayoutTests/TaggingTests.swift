//
//  TaggingTests.swift
//  WWLayoutTests
//
//  Created by Steven Grosmark on 5/7/18.
//  Copyright © 2018 Weight Watchers International, Inc. All rights reserved.
//

import XCTest
@testable import WWLayout

class TaggingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Tags_Create() {
        // given
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        
        // when
        let constraints = child.layout.fill(.superview, tag: 5).constraints()
        
        // then
        XCTAssertEqual(constraints.count, 4)
        for constraint in constraints {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 5)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
        
        let foundConstraints = Layout.findConstraints(in: container, tag: 5)
        XCTAssertEqual(foundConstraints, constraints)
        XCTAssertEqual(Layout.findConstraints(in: container, tag: 8).count, 0)
    }
    
    func test_Tags_MultistepCreate() {
        // given
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        
        // when
        var constraints = child.layout.fill(.superview, tag: 5).constraints()
        constraints += child.layout.center(in: .superview, tag: 5).constraints()
        
        // then
        XCTAssertEqual(constraints.count, 6)
        for constraint in constraints {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 5)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
        
        let foundConstraints = Layout.findConstraints(in: container, tag: 5)
        XCTAssertEqual(foundConstraints, constraints)
        XCTAssertEqual(Layout.findConstraints(in: container, tag: 8).count, 0)
    }
    
    func test_Tags_CreateInactive() {
        // given
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        
        // when
        let constraints = child.layout.fill(.superview, tag: 5, active: false).constraints()
        
        // then
        for constraint in constraints {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 5)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, false)
        }
        
        let foundConstraints = Layout.findConstraints(in: container, tag: 5)
        XCTAssertEqual(foundConstraints, constraints)
        XCTAssertEqual(Layout.findConstraints(in: container, tag: 4).count, 0)
    }
    
    func test_Tags_CreateViaLayout() {
        // given
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        
        // when
        child.layout.center(in: .superview) // un-tagged
        let constraints = child.layout(tag: 999)
            .fill(.superview)
            .constraints()
        
        // then
        XCTAssertEqual(constraints.count, 4)
        for constraint in constraints {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 999)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
        
        let foundConstraints = Layout.findConstraints(in: container, tag: 999)
        XCTAssertEqual(foundConstraints, constraints)
        XCTAssertEqual(Layout.findConstraints(in: container, tag: 5).count, 0)
    }
    
    func test_Tags_CreateInactiveViaLayout() {
        // given
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        
        // when
        child.layout.center(in: .superview) // un-tagged
        let constraints = child.layout(tag: 999, active: false)
            .fill(.superview)
            .constraints()
        
        // then
        XCTAssertEqual(constraints.count, 4)
        for constraint in constraints {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 999)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, false)
        }
        
        let foundConstraints = Layout.findConstraints(in: container, tag: 999)
        XCTAssertEqual(foundConstraints, constraints)
        XCTAssertEqual(Layout.findConstraints(in: container, tag: 5).count, 0)
    }
    
    func test_Tags_Activate() {
        // given
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        
        // when
        child.layout.center(in: .superview) // un-tagged
        child.layout(tag: 999).fill(.superview)
        
        // then
        let constraints = Layout.findConstraints(in: container, tag: 999)
        XCTAssertEqual(constraints.count, 4)
        for constraint in constraints {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 999)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
        
        // when
        Layout.deactivateConstraints(in: container, tag: 999)
        
        // then
        for constraint in Layout.findConstraints(in: container, tag: 999) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, false)
        }
        
        // when
        Layout.activateConstraints(in: container, tag: 999)
        
        // then
        for constraint in Layout.findConstraints(in: container, tag: 999) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
    }
    
    func test_Tags_ActivateDeactivate() {
        // given
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        
        // when
        // create some active, some not
        child.layout.center(in: .superview, tag: 111, active: false)
        child.layout(tag: 999).fill(.superview)
        
        // then
        // make sure they were created ok
        let constraints1 = Layout.findConstraints(in: container, tag: 111)
        XCTAssertEqual(constraints1.count, 2)
        for constraint in constraints1 {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 111)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, false)
        }
        let constraints2 = Layout.findConstraints(in: container, tag: 999)
        XCTAssertEqual(constraints2.count, 4)
        for constraint in constraints2 {
            XCTAssertEqual((constraint as? LayoutConstraint)?.tag, 999)
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
        
        // when
        // switch active state for the two tags
        Layout.switchActiveConstraints(in: container, activeTag: 111, deactiveTag: 999)
        container.layoutIfNeeded()
        
        // then
        // active status should have swapped
        for constraint in Layout.findConstraints(in: container, tag: 111) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
        for constraint in Layout.findConstraints(in: container, tag: 999) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, false)
        }
        
        // when
        // switch to same state (i.e. a noop)
        Layout.switchActiveConstraints(in: container, activeTag: 111, deactiveTag: 999)
        container.layoutIfNeeded()
        
        // then
        // active status should not have changed
        for constraint in Layout.findConstraints(in: container, tag: 111) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
        for constraint in Layout.findConstraints(in: container, tag: 999) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, false)
        }
        
        // when
        // switch active state back for the two tags
        Layout.switchActiveConstraints(in: container, activeTag: 999, deactiveTag: 111)
        container.layoutIfNeeded()
        
        // then
        // active status should have swapped back
        for constraint in Layout.findConstraints(in: container, tag: 111) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, false)
        }
        for constraint in Layout.findConstraints(in: container, tag: 999) {
            XCTAssertEqual((constraint as? LayoutConstraint)?.isActive, true)
        }
    }
    
}
