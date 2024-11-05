//
//  SessionHandler.swift
//  NetworkManager
//
//  Created by Frank Thamel on 05/11/2024.
//

import Foundation

public struct SessionHandler {
    public var data: (URLRequest) async throws -> (Data, URLResponse)
    
    init(
        data: @escaping (URLRequest) async throws -> (Data, URLResponse)
    ) {
        self.data = data
    }
}
