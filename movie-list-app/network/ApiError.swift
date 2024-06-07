//
//  ApiErrorHandlr.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 05/06/24.
//

import Foundation

enum ApiError: Error {
    case networkError(Error)
    case httpError(Int)
    case decodingError(Error)
    case unknownError
}
