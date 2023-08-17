//
//  GustatiaUITests.swift
//  GustatiaUITests
//
//  Created by David Alvarado on 7/18/23.
//

import XCTest

final class GustatiaUITests: XCTestCase {
    
    func testAppContainsRecipeEntry() throws {
        let app = XCUIApplication()
        app.launch()
        
        guard app.wait(for: .runningForeground, timeout: 10) else {
            XCTFail("App did not achieve expected state in time")
            return
        }
        
        XCTAssertTrue(app.staticTexts["Gustatia Test Recipe"].exists)
    }

    func testLaunchAndRunPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                let app = XCUIApplication()
                app.launch()
                guard app.wait(for: .runningForeground, timeout: 10) else {
                    XCTFail("App did not achieve expected state in time")
                    return
                }
            }
        }
    }
}
