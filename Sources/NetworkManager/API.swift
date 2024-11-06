//
//  API.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import Foundation

/// A structure that represents an API endpoint configuration.
///
/// Use this structure to define the components of your API endpoints, including the scheme,
/// base URL, path, query parameters, HTTP method, and headers. It's typically used with an enum
/// to create a type-safe API client.
///
/// Example:
/// ```swift
/// enum BookmarksAPI {
///     case all
///     case get(Bookmark.ID)
///     case create(Bookmark)
///     case update(Bookmark)
///     case delete(Bookmark.ID)
/// }
///
/// static func bookmarks(api: BookmarksAPI) -> API {
///     API(
///         scheme: { .https },
///         baseURL: { "api.example.com" },
///         path: {
///             switch api {
///             case .all: return "/bookmarks"
///             case .get(let id): return "/bookmarks/\(id)"
///             case .create: return "/bookmarks"
///             case .update(let bookmark): return "/bookmarks/\(bookmark.id)"
///             case .delete(let id): return "/bookmarks/\(id)"
///             }
///         },
///         parameters: { nil },
///         method: {
///             switch api {
///             case .all, .get: return .get
///             case .create: return .post
///             case .update: return .put
///             case .delete: return .delete
///             }
///         },
///         headers: { [:] },
///         body: { nil }   
///     )
/// }
///
/// // Usage:
/// let getAllBookmarks = API.bookmarks(api: .all)
/// let getBookmark = API.bookmarks(api: .get("123"))
/// let createBookmark = API.bookmarks(api: .create(newBookmark))
/// ```
///
/// The API structure uses closures for all properties, allowing for dynamic values that are
/// evaluated when the endpoint is used.
public struct API {
    public var scheme: () -> HTTPScheme
    public var baseURL: () -> String
    public var path: () -> String
    public var parameters: () -> [URLQueryItem]?
    public var method: () -> HTTPMethod
    public var headers: () -> [String: String]?
    public var body: () -> Encodable?
    
    public init(
        scheme: @escaping () -> HTTPScheme,
        baseURL: @escaping () -> String,
        path: @escaping () -> String,
        parameters: @escaping () -> [URLQueryItem]? = { nil },
        method: @escaping () -> HTTPMethod,
        headers: @escaping () -> [String: String]? = { nil },
        body: @escaping () -> Encodable? = { nil }
    ) {
        self.scheme = scheme
        self.baseURL = baseURL
        self.path = path
        self.parameters = parameters
        self.method = method
        self.headers = headers
        self.body = body
    }
}
