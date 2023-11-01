//
//  DataClient.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/29/23.
//

import Foundation

enum HTTPMethod: String {

    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
}
typealias HTTPHeaders = [String: String]


struct UrlRequestDetails {

    public var url: URL
    public let method: HTTPMethod
    public let headers: HTTPHeaders?

    // MARK: - Initializer

    public init(url: URL,
                method: HTTPMethod = .get,
                headers: HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
    }
}

class DataClient {
 
    func requestWithAsync<T: Decodable>(urlRequestDetails: UrlRequestDetails) async throws -> T {

        do {
            let jsonDecoder = JSONDecoder()
            var urlRequest = URLRequest(url: urlRequestDetails.url)
            
            if let headers = urlRequestDetails.headers {
                urlRequest.allHTTPHeaderFields = headers
            }
            urlRequest.httpMethod = urlRequestDetails.method.rawValue
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            let countries = try jsonDecoder.decode(T.self, from: data)
            return countries

        } catch(let error) {
            throw error
        }
    }
}
