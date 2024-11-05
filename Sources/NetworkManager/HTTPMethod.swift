//
//  HTTPMethod.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import Foundation

/// An enumeration representing standard HTTP methods used in API requests.
///
/// This enum provides type-safe HTTP method definitions that conform to the HTTP/1.1 protocol specification.
/// Each case represents a different HTTP method and its corresponding string value.
///
/// Example:
/// ```swift
/// let method: HTTPMethod = .get
/// print(method.rawValue) // Prints: "GET"
/// ```
public enum HTTPMethod: String, Equatable {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
