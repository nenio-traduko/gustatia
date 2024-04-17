//
//  TimeInterval+FormattedString.swift
//  GustatiaTests
//
//  Created by David Alvarado on 10/17/23.
//

import XCTest

final class TimeInterval_FormattedStringTests: XCTestCase {

    func testIntervalStringDoesNotIncludeSeconds() {
        let subject = TimeInterval(floatLiteral: 1.0)
        XCTAssertEqual(subject.formattedString, "0 min")
    }
    
    func testIntervalStringRoundsDownToMinute() {
        let subject = TimeInterval(floatLiteral: 359)
        XCTAssertEqual(subject.formattedString, "5 min")
    }
    
    func testIntervalStringIncludesHours() {
        let subject = TimeInterval(floatLiteral: 3660)
        XCTAssertEqual(subject.formattedString, "1 hr, 1 min")
    }
    
    func testIntervalStringIncludesMonths() {
        let subject = TimeInterval(floatLiteral: 6628000.0)
        XCTAssertEqual(subject.formattedString, "2 mths, 425 hr, 6 min")
    }

    func testPerformanceOnLargeValues() throws {
        let subject = TimeInterval(floatLiteral: 1628000000.0)
        
        self.measure {
            _ = subject.formattedString
        }
    }

}
