//
//  MovieApiProvider.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation
import http_client

// https://api.themoviedb.org/3/movie/latest
// https://api.themoviedb.org/3/movie/popular?language=en-US&page=1
//https://api.themoviedb.org/3/collection/collection_id?language=en-US

enum MovieApiProvider: String {
    // add api endpoint
    case popular = "popular"
    case latest = "now_playing"
    case details = ""
}

extension MovieApiProvider: ApiEndpoint {

    var baseURLString: String {
        AppUrl.baseUrl.rawValue
    }
    
    var apiPath: String {
        "movie"
    }
    
    var apiVersion: String {
        AppUrl.version.rawValue
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var method: HTTPMethod {
        HTTPMethod.GET
    }
    
    var apiKey: String? {
        return AppUrl.apiKey.rawValue
    }
}
