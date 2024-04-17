//
//  GustatiaAppTests.swift
//  GustatiaAppTests
//
//  Created by David Alvarado on 7/18/23.
//

import XCTest

final class GustatiaAppTests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.activate()
        
        guard app.wait(for: .runningForeground, timeout: 10) else {
            XCTFail("App did not achieve expected state in time")
            return
        }
    }
    
    func testAppContainsAddRecipePromptWhenListIsEmpty() {
        XCTAssertTrue(app.staticTexts["Add a recipe to get started."].exists)
    }
    
    func testAppContainsRecipesTitle() {
        XCTAssertTrue(app.navigationBars["Recipes"].exists)
    }
    
    func testAppContainsAddRecipesButton() {
        XCTAssertTrue(app.buttons["Add recipe"].exists)
    }
}
