//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import Foundation

/// A class that provides a type-safe way to perform network requests.
///
/// Use this class to perform network requests with a given API configuration. It handles the
/// construction of the URL, the addition of headers, and the parsing of the response.
///
/// Example:
/// ```swift
/// // Define your model
/// struct Bookmark: Decodable, Equatable {
///     let id: Int
///     let title: String
/// }
///
/// // Create an API endpoint
/// let endpoint = API.bookmarks(api: .get(1234))
///
/// // Make the request
/// do {
///     let bookmark: Bookmark = try await NetworkManager.request(
///         endpoint: endpoint,
///         sessionHandler: .live()
///     )
///     print("Received bookmark: \(bookmark.title)")
/// } catch {
///     switch (error as? URLError)?.code {
///     case .badServerResponse:
///         print("Server returned an error status code")
///     case .cannotParseResponse:
///         print("Failed to parse the response")
///     default:
///         print("An error occurred: \(error)")
///     }
/// }
/// ```
///
/// The class handles common networking scenarios including:
/// - URL construction from endpoint configuration
/// - HTTP method and header setup
/// - Response status code validation
/// - JSON decoding to your model types
/// - Error handling for network and parsing failures
public final class NetworkManager {
    
    // Builds URL from the API configuration
    private class func buildURL(endpoint: API) -> URLComponents? {
        
        let baseURL = "\(endpoint.scheme().rawValue)://\(endpoint.baseURL())"
        var components = URLComponents(string: baseURL)
        components?.path = endpoint.path()
        components?.queryItems = endpoint.parameters()
        return components
    }
    
    /// A generic request method using async/await.
    ///
    /// This method constructs the URL from the provided API configuration, performs the network request,
    /// and parses the response as a decodable type.
    ///
    /// - Parameters:
    ///   - endpoint: The API configuration defining the endpoint details.
    ///   - sessionHandler: The session handler to use for the request. Defaults to a live session.
    /// - Returns: The decoded response from the API.
    /// - Throws: An error if the request fails or the response cannot be parsed.
    public class func request<T: Decodable>(
        endpoint: API,
        sessionHandler: SessionHandler = .live()
    ) async throws -> T {
        // Build the URL from the endpoint
        guard let url = buildURL(endpoint: endpoint)?.url else {
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

        // Encode the body if any
        if let body = endpoint.body() {
            request.httpBody = try JSONEncoder().encode(body)
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

    /// A request method for endpoints that don't return data (like DELETE operations).
    ///
    /// This method constructs the URL from the provided API configuration and performs the network request
    /// without attempting to decode any response data.
    ///
    /// - Parameters:
    ///   - endpoint: The API configuration defining the endpoint details.
    ///   - sessionHandler: The session handler to use for the request. Defaults to a live session.
    /// - Throws: An error if the request fails.
    public class func request(
        endpoint: API,
        sessionHandler: SessionHandler = .live()
    ) async throws {
        // Build the URL from the endpoint
        guard let url = buildURL(endpoint: endpoint)?.url else {
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

        // Encode the body if any
        if let body = endpoint.body() {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        // Perform network request
        let (_, response) = try await sessionHandler.data(request)
        
        // Ensure response is HTTPURLResponse and status code is in the 200 range
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}

