//
//  XCUITestInteractionUtility.swift
//  GustatiaUITests
//
//  Created by David Alvarado on 10/23/23.
//

import XCTest

struct XCUITestInteractionUtility {
    let app: XCUIApplication
    
    init(for app: XCUIApplication) {
        self.app = app
    }
    
    func tap(_ element: XCUIElement) throws {
        try swipeToHit(element)
        element.tap()
    }
    
    func type(into element: XCUIElement, text: String) throws {
        try tap(element)
        element.typeText(text)
    }
    
    func exists(_ element: XCUIElement) throws -> Bool {
        try swipeToHit(element)
        return element.exists
    }
    
    func step(_ stepperName: String, to value: String) throws {
        let addServingsButton = app.buttons.element(matching: NSPredicate(format: "'Increment' IN identifiers AND '\(stepperName)' IN label"))
        XCTAssertTrue(addServingsButton.exists)
        
        let servingsRegex = try Regex(value)
        while !addServingsButton.label.contains(servingsRegex) {
            try tap(addServingsButton)
        }
    }
    
    private func swipeToHit(_ element: XCUIElement, maxScrollCount: Int = 5) throws {
        guard !element.isHittable else {
            return
        }
        
        let scrollBar = app.otherElements.element(matching: NSPredicate(format: "'Vertical scroll bar' IN label"))
        
        var swipesCount = 0
        
        while(!element.isHittable) {
            guard swipesCount < maxScrollCount else {
                throw XCTestError(.failureWhileWaiting, userInfo: ["description": "Element was not hittable after max scroll count."])
            }
            
            scrollBar.swipeUp(velocity: .slow)
            swipesCount += 1
        }
    }
}
