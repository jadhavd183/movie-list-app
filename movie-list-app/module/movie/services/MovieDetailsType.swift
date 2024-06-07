//
//  MovieDetailsType.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation

protocol MovieDetailsType {
    func callMovieDetailsByIdApi(movieId: String) async throws -> MovieDetail
}
