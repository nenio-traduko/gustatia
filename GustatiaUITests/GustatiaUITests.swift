//
//  GustatiaUITests.swift
//  GustatiaUITests
//
//  Created by David Alvarado on 7/18/23.
//

import XCTest

final class GustatiaUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        guard app.wait(for: .runningForeground, timeout: 10) else {
            XCTFail("App did not achieve expected state in time")
            return
        }
    }
    
    func testA1_AppContainsAddRecipePromptWhenListIsEmpty() {
        XCTAssertTrue(app.staticTexts["Add a new recipe to get started."].exists)
    }
    
    func testA2_AppContainsRecipesTitle() {
        XCTAssertTrue(app.navigationBars["Recipes"].exists)
    }
    
    func testA3_AppContainsAddRecipesButton() {
        XCTAssertTrue(app.buttons["Add recipe"].exists)
    }
    
    func testB1_AppRemovesPromptWhenAddRecipesButtonIsPressed() {
        app.buttons["Add recipe"].tap()
        XCTAssertFalse(app.staticTexts["Add a new recipe to get started."].exists)
    }
    
    func testB2_AppAddsEntryWhenAddRecipesButtonIsPressed() {
        app.buttons["Add recipe"].tap()
    }
}
