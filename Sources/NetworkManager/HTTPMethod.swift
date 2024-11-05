//
//  HTTPMethod.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import Foundation

public enum HTTPMethod: String, Equatable {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
