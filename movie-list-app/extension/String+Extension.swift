//
//  String.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation

extension String {
    func convertToStandardDateFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
