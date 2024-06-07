//
//  Int+Extension.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 07/06/24.
//

import Foundation

extension Int {
    func toHoursAndMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        return "\(hours)h \(minutes)m"
    }
    
    func formattedWithCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
