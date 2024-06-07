//
//  ApiEndPoint.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

protocol ApiEndpoint {
    var baseURLString: String { get }
    var apiPath: String { get }
    var apiVersion: String { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var apiKey: String? { get }
}

extension ApiEndpoint where Self: RawRepresentable, RawValue == String  {
    
    func makeRequest(pathComponent: String? = nil) -> URLRequest {
        var urlComponents = URLComponents(string: baseURLString)
        var longPath = "/" + apiVersion + "/" + apiPath + "/" + rawValue

        // add path component if passed
        if let pathComponent =  pathComponent {
            longPath.append("/\(pathComponent)")
        }
       
        urlComponents?.path = longPath
        
        guard let url = urlComponents?.url else { return URLRequest(url: URL(string: baseURLString)!) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return request
    }
    
    func makeRequest(pathComponent: String? = nil, params: [String: String]) -> URLRequest {
        var request = makeRequest(pathComponent: pathComponent)
        var queryParams = params
        queryParams["api_key"] = apiKey
        request.appendQueryParameters(queryParams)
        return request
    }
    
    func makeRequest(pathComponent: String? = nil, httpBody: Data) -> URLRequest {
        var request = makeRequest(pathComponent: pathComponent)
        request.httpBody = httpBody
        return request
    }
    
}
