//
//  Utils.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

// MARK: - DateFormatter

extension DateFormatter {
    
    public static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
}

// MARK: - Date

extension Date {
    
    func toString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        
        return dateFormatter.string(from: self)
    }
    
}
