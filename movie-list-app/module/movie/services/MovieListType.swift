//
//  MovieListType.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation

protocol MovieListType {
    func callPopularMoviesApi(page: Int) async throws -> [Movie]
    func callLatestMoviesApi(page: Int) async throws -> [Movie]
}
