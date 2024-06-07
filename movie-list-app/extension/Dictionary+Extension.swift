//
//  Dictionary+Extension.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation

extension Dictionary where Key == String {
    
    func percentEncoded() -> Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
}
