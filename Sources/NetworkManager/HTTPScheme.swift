//
//  HTTPScheme.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import Foundation

/// An enumeration representing standard HTTP schemes used in API requests.
///
/// This enum provides type-safe HTTP scheme definitions that conform to the HTTP/1.1 protocol specification.
/// Each case represents a different HTTP scheme and its corresponding string value.
///
/// Example:
/// ```swift
public enum HTTPScheme: String, Equatable {
    case http
    case https
}
