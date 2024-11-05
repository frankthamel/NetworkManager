//
//  SessionHandler.swift
//  NetworkManager
//
//  Created by Frank Thamel on 05/11/2024.
//

import Foundation

/// A structure that represents a session handler.
///
/// Use this structure to handle the data for a given URL request.
public struct SessionHandler {
    public var data: (URLRequest) async throws -> (Data, URLResponse)
    
    init(
        data: @escaping (URLRequest) async throws -> (Data, URLResponse)
    ) {
        self.data = data
    }
}
