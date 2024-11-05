//
//  API.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import Foundation

public struct API {
    public var scheme: () -> HTTPScheme
    public var baseURL: () -> String
    public var path: () -> String
    public var parameters: () -> [URLQueryItem]?
    public var method: () -> HTTPMethod
    public var headers: () -> [String: String]?
    
    public init(
        scheme: @escaping () -> HTTPScheme,
        baseURL: @escaping () -> String,
        path: @escaping () -> String,
        parameters: @escaping () -> [URLQueryItem]? = { nil },
        method: @escaping () -> HTTPMethod,
        headers: @escaping () -> [String: String]? = { nil }
    ) {
        self.scheme = scheme
        self.baseURL = baseURL
        self.path = path
        self.parameters = parameters
        self.method = method
        self.headers = headers
    }
}
