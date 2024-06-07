//
//  MovieService.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 05/06/24.
//

import Foundation

class MovieService: MovieListType, MovieDetailsType {
    let httpClient: HttpClient
    
    init(httpClient: HttpClient = URLSession.shared) {
        self.httpClient = httpClient
    }
    
    func callPopularMoviesApi(page: Int) async throws -> [Movie]{
        let request = MovieApiProvider.popular.makeRequest(params: ["language": "en-US", "page" : "\(page)"])
        let result: MovieListResponse = try await httpClient.makeAsyncApiCall(for: request)
        return result.movies
    }
    
    func callLatestMoviesApi(page: Int) async throws -> [Movie]{
        let request = MovieApiProvider.latest.makeRequest(params: ["language": "en-US", "page" : "\(page)"])
        let result: MovieListResponse = try await httpClient.makeAsyncApiCall(for: request)
        return result.movies
    }
    
    func callMovieDetailsByIdApi(movieId: String) async throws -> MovieDetail {
        let request = MovieApiProvider.details.makeRequest(pathComponent: movieId,params: ["language" : "en-US"])
        let movieDetail: MovieDetail = try await httpClient.makeAsyncApiCall(for: request)
        return movieDetail
    }
    
}
