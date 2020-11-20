//
//  Book.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let kind, id, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    
    struct VolumeInfo: Codable {
        let title: String
        let subtitle: String?
        let authors: [String]?
        let publisher: String?
        let publishedDate: String?
        let bookDescription: String?
        let imageLinks: ImageLinks?
        let language: String
        
        enum CodingKeys: String, CodingKey {
            case title, subtitle, authors, publisher, publishedDate, imageLinks, language
            case bookDescription = "description"
        }
        
        struct ImageLinks: Codable {
            let smallThumbnail: String
            let thumbnail: String
        }
    }
}
