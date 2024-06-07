//
//  MovieTests.swift
//  movie-list-appTests
//
//  Created by Jadhav, Dhananjay on 07/06/24.
//

import XCTest
@testable import movie_list_app

class MovieDetailsTests: XCTestCase {
    var movieAPI: MovieDetailsType!
    var movieId: Int = 653346
    
    override func setUp() {
        super.setUp()
        movieAPI = MovieService()
    }
    
    override func tearDown() {
        movieAPI = nil
        super.tearDown()
    }
    
    func testMovieDetailsById() {
        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch Movies details by id")

        Task {
            // Perform the asynchronous operation
            let result = try? await movieAPI.callMovieDetailsByIdApi(movieId: String(describing: movieId))
            
            // Fulfill the expectation once the operation completes
            XCTAssertNotNil(result)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled or timeout after a certain duration
        let result = XCTWaiter().wait(for: [expectation], timeout: 10)
        XCTAssertEqual(result, .completed, "Test timed out.")
    }
    
    
    func testMovieDecoding() {
        if let data = loadJSONData(from: "latest_movies") {
            let movieDetails = try? JSONDecoder().decode(MovieDetail.self, from: data)
                XCTAssertNotNil(movieDetails)
            XCTAssertNotNil(movieDetails)
        }  
    }
}
