//
//  BookmarksAPI.swift
//  NetworkManager
//
//  Created by Frank Thamel on 05/11/2024.
//

import Foundation
import NetworkManager

extension API {
    enum BookmarksAPI {
        case all
        case get(Bookmark.ID)
        case create(Bookmark)
        case update(Bookmark)
        case delete(Bookmark.ID)
    }
    
    static func bookmarks(api: BookmarksAPI) -> API {
        API(
            scheme: { .https },
            baseURL: { "api.example.com" },
            path: {
                switch api {
                case .all: return "/bookmarks"
                case .get(let id): return "/bookmarks/\(id)"
                case .create: return "/bookmarks"
                case .update(let bookmark): return "/bookmarks/\(bookmark.id)"
                case .delete(let id): return "/bookmarks/\(id)"
                }
            },
            parameters: { nil },
            method: {
                switch api {
                case .all, .get: return .get
                case .create: return .post
                case .update: return .put
                case .delete: return .delete
                }
            },
            headers: { [:] }
        )
    }
}
