import Foundation
import XCTest
@testable import NetworkManager

final class NetworkManagerTests: XCTestCase {
    
    func testRequest_SuccessfulResponse() async throws {
        // Arrange
        let mockData = """
        {
            "id": 1234,
            "title": "https://iosdevlibrary.lemonsqueezy.com"
        }
        """.data(using: .utf8)!
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://iosdevlibrary.lemonsqueezy.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let mockSessionHandler = SessionHandler(
            data: { _ in
                return (mockData, mockResponse)
            }
        )
        
        let mockAPI = API.bookmarks(api: .get(1234))
        
        // Act
        let result: Bookmark = try await NetworkManager.request(endpoint: mockAPI, sessionHandler: mockSessionHandler)
        
        // Assert
        XCTAssertEqual(
            result,
            Bookmark(id: 1234, title: "https://iosdevlibrary.lemonsqueezy.com")
        )
    }
    
    func testRequest_BadServerResponseThrowsError() async {
        // Arrange
        let mockData = """
            {
                "id": 1234,
                "title": "https://iosdevlibrary.lemonsqueezy.com"
            }
            """.data(using: .utf8)!
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://iosdevlibrary.lemonsqueezy.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let mockSessionHandler = SessionHandler(
            data: { _ in
                return (mockData, mockResponse)
            }
        )
        
        let mockAPI = API.bookmarks(api: .get(1234))
        
        // Act & Assert
        do {
            let _: Bookmark = try await NetworkManager.request(endpoint: mockAPI, sessionHandler: mockSessionHandler)
            XCTFail("Should have thrown an error")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }

    
    func testRequest_CannotParseResponseThrowsError() async {
        // Arrange
        let invalidData = "Invalid JSON".data(using: .utf8)!
     
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://iosdevlibrary.lemonsqueezy.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        let mockSessionHandler = SessionHandler(
            data: { _ in
                return (invalidData, mockResponse)
            }
        )
        
        let mockAPI = API.bookmarks(api: .get(1234))
        
        // Act & Assert
        do {
            let _: Bookmark = try await NetworkManager.request(endpoint: mockAPI, sessionHandler: mockSessionHandler)
            XCTFail("Should have thrown an error")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .cannotParseResponse)
        }
        
    }
}

// Sample Decodable model for testing
struct User: Decodable {
    let name: String
    let age: Int
}



