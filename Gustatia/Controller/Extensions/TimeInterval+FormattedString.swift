//
//  TimeInterval+ToFormattedString.swift
//  Gustatia
//
//  Created by David Alvarado on 10/1/23.
//

import Foundation

extension TimeInterval {
    var formattedString: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.month, .hour, .minute]
        return formatter.string(from: self) ?? "n/a"
    }
}
