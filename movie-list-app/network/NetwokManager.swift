//
//  NetwokManager.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 05/06/24.
//

import Foundation

protocol HttpClient {
    func makeAsyncApiCall<T: Codable>(for request: URLRequest) async throws -> T
}

extension URLSession: HttpClient, URLSessionDelegate {
    func makeAsyncApiCall<T: Decodable>(for request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.unknownError
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw ApiError.httpError(httpResponse.statusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw ApiError.decodingError(error)
            }
        } catch {
            throw ApiError.networkError(error)
        }
    }
}
