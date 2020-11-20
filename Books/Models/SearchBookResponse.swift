//
//  SearchBookResponse.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import Foundation

// MARK: - SearchBookResponse
struct SearchBookResponse: Codable {
    let kind: String
    let totalItems: Int
    let items: [Book]
}
