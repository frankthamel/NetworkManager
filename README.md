# NetworkManager

A modern, scalable, and testable network layer in Swift, leveraging modern concurrency and designed for flexibility with `enum`-based configuration. 

**Note**: This network layer is created for educational purposes to help developers learn about building network layers in Swift using modern async/await concurrency, along with a flexible API configuration.

## Features

- **Async/Await Support**: Uses modern Swift concurrency for simplified asynchronous code.
- **Enum-based Configuration**: Configurable endpoints using enums for HTTP methods and schemes.
- **Generic Decoding**: Easily handles different API responses using generic decoding for `Decodable` types.
- **Customizable API Struct**: Flexible structure to handle query parameters, headers, and other endpoint configurations.

## Requirements

- Swift 5.5+
- iOS 13.0+, macOS 10.15+, or watchOS 6.0+ (due to async/await support)
- Xcode 13+

## Installation

Copy `NetworkManager.swift` and `API.swift` into your project.

Alternatively, if you're using this as a Swift Package, add it to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/frankthamel/NetworkManager.git", from: "0.0.1")
]
```

## Documentation

[NetworkManager Documentation](https://frankthamel.github.io/NetworkManager/documentation/networkmanager/)
