//
//  APITests.swift
//  NetworkManager
//
//  Created by Frank Thamel on 04/11/2024.
//

import XCTest
@testable import NetworkManager

final class APITests: XCTestCase {
    func test_bookmarks_fetchAll() throws {
        // Arrange / Act
        let bookmarksAPI: API = .bookmarks(api: .all)
        
        // Assert
        XCTAssertEqual(bookmarksAPI.scheme(), .https)
        XCTAssertEqual(bookmarksAPI.baseURL(), "api.example.com")
        XCTAssertEqual(bookmarksAPI.path(), "/bookmarks")
        XCTAssertEqual(bookmarksAPI.parameters(), nil)
        XCTAssertEqual(bookmarksAPI.method(), .get)
    }
    
    func test_bookmarks_update() throws {
        // Arrange / Act
        let bookmarksAPI: API = .bookmarks(
            api: .update(Bookmark(id: 2222, title: "Updated"))
        )
        
        // Assert
        XCTAssertEqual(bookmarksAPI.scheme(), .https)
        XCTAssertEqual(bookmarksAPI.baseURL(), "api.example.com")
        XCTAssertEqual(bookmarksAPI.path(), "/bookmarks/2222")
        XCTAssertEqual(bookmarksAPI.parameters(), nil)
        XCTAssertEqual(bookmarksAPI.method(), .put)
    }
}
