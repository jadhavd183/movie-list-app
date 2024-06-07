//
//  URLRequest+Extension.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation

extension URL {
    func appendingQueryParameters(_ parameters: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}

extension URLRequest {
    mutating func appendQueryParameters(_ parameters: [String: String]) {
        guard let url = self.url else { return }
        if let updatedURL = url.appendingQueryParameters(parameters) {
            self.url = updatedURL
        }
    }
}


