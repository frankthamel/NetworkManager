//
//  SessionHandler+Live.swift
//  NetworkManager
//
//  Created by Frank Thamel on 05/11/2024.
//

import Foundation

public extension SessionHandler {
    static func live(session: URLSession = URLSession.shared) -> SessionHandler {
        SessionHandler(
            data: { request in
                try await session.data(for: request)
            }
        )
    }
}
