//
//  SessionHandler+Live.swift
//  NetworkManager
//
//  Created by Frank Thamel on 05/11/2024.
//

import Foundation

public extension SessionHandler {
    /// A live session handler that uses the shared URL session.
    ///
    /// This method creates a session handler that uses the shared URL session to perform the request.
    static func live(session: URLSession = URLSession.shared) -> SessionHandler {
        SessionHandler(
            data: { request in
                try await session.data(for: request)
            }
        )
    }
}
