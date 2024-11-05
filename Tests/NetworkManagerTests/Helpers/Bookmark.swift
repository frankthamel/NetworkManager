//
//  Bookmark.swift
//  NetworkManager
//
//  Created by Frank Thamel on 05/11/2024.
//

import Foundation

struct Bookmark: Identifiable, Equatable, Decodable {
    let id: Int
    let title: String
}
