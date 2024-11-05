//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import Foundation

public final class NetworkManager {
    
    // Builds URL from the API configuration
    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme().rawValue
        components.host = endpoint.baseURL()
        components.path = endpoint.path()
        components.queryItems = endpoint.parameters()
        return components
    }
    
    // Generic request method using async/await
    class func request<T: Decodable>(
        endpoint: API,
        sessionHandler: SessionHandler = .live()
    ) async throws -> T {
        // Build the URL from the endpoint
        guard let url = buildURL(endpoint: endpoint).url else {
            throw URLError(.badURL)
        }
        
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method().rawValue
        
        // Add headers if any
        if let headers = endpoint.headers() {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Perform network request
        let (data, response) = try await sessionHandler.data(request)
        
        // Ensure response is HTTPURLResponse and status code is in the 200 range
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Decode the JSON response
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw URLError(.cannotParseResponse)
        }
    }
}

