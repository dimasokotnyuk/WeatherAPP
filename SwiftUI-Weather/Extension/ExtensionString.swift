//
//  ExtensionString.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import Foundation

extension String {
    private func convertDateFormat(from inputFormat: String, to outputFormat: String, localeIdentifier: String = "en_US") -> String? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = inputFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = formatter.date(from: self) else {
            return nil
        }
        
        formatter.dateFormat = outputFormat
        formatter.locale = Locale(identifier: localeIdentifier)
        
        return formatter.string(from: date)
    }
    
    func toHourString() -> String? {
        return convertDateFormat(from: "yyyy-MM-dd HH:mm", to: "HH")
    }
    
    func toShortWeekdayString() -> String? {
        return convertDateFormat(from: "yyyy-MM-dd", to: "EEE", localeIdentifier: "en_USA")
    }
    
    func toFullDateString() -> String? {
        return convertDateFormat(from: "yyyy-MM-dd HH:mm", to: "EEEE, d MMMM", localeIdentifier: "en_USA")
    }
}
