//
//  XCTestCase+ScreenshotUtilities.swift
//  GustatiaUITests
//
//  Created by David Alvarado on 10/23/23.
//

import XCTest


extension XCTestCase {
    func addScreenshot(screenshotProvider: XCUIScreenshotProviding, lifetime: XCTAttachment.Lifetime = .keepAlways) {
        let screenshot = screenshotProvider.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = lifetime
        add(attachment)
    }
}
