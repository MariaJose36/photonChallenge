//
//  nycUITests.swift
//  nycUITests
//
//  Created by Cincinnati Ai on 3/5/24.
//

import XCTest

final class nycUITests: XCTestCase {
    
    func test_schoolsShouldGetDisplayed() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssert(app.collectionViews["school list"].cells.firstMatch.waitForExistence(timeout: 5))
    }
}
