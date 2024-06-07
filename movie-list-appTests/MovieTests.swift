//
//  MovieTests.swift
//  movie-list-appTests
//
//  Created by Jadhav, Dhananjay on 07/06/24.
//

import XCTest
@testable import movie_list_app

class MovieTests: XCTestCase {

    var movieAPI: MovieListType!
    
    override func setUp() {
        super.setUp()
        movieAPI = MovieService()
    }
    
    override func tearDown() {
        movieAPI = nil
        super.tearDown()
    }
    
    func testFetchLatestMovies() {
        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch latest movies")

        Task {
            // Perform the asynchronous operation
            let result = try? await movieAPI.callLatestMoviesApi(page:1)
            XCTAssertNotNil(result)
            
            // Fulfill the expectation once the operation completes
            XCTAssertNotNil(result)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled or timeout after a certain duration
        let result = XCTWaiter().wait(for: [expectation], timeout: 10)
        XCTAssertEqual(result, .completed, "Test timed out.")
    }
    
    func testFetchPopularMovies() {
        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch latest movies")

        Task {
            // Perform the asynchronous operation
            let result = try? await movieAPI.callPopularMoviesApi(page: 1)
            XCTAssertNotNil(result)
            
            // Fulfill the expectation once the operation completes
            XCTAssertNotNil(result)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled or timeout after a certain duration
        let result = XCTWaiter().wait(for: [expectation], timeout: 10)
        XCTAssertEqual(result, .completed, "Test timed out.")
    }
    
    func testPopularMovieDecoding() {
        if let data = loadJSONData(from: "popular_movies") {
            let movieListResponse = try? JSONDecoder().decode(MovieListResponse.self, from: data)
            XCTAssertNotNil(movieListResponse)
        }
    }
    
    func testLatestMovieDecoding() {
        if let data = loadJSONData(from: "latest_movies") {
            let movieListResponse = try? JSONDecoder().decode(MovieListResponse.self, from: data)
            XCTAssertNotNil(movieListResponse)
        }
    }
}
