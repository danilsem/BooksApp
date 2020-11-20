//
//  BooksFavoritesService.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import Foundation

protocol BooksFavoritesServiceProtocol: class {
    func save(id: String)
    func get() -> [String]
    func clear()
    func isBookFavorite(id: String) -> Bool
    func delete(id: String)
}

final class BooksFavoritesService: BooksFavoritesServiceProtocol {
    static let shared = BooksFavoritesService()
    private init() { }
    
    private enum Keys: String {
        case books
    }
    
    let userDefaults = UserDefaults.standard
    
    func save(id: String) {
        if var booksArray = userDefaults.array(forKey: Keys.books.rawValue) as? [String] {
            guard !booksArray.contains(id) else { return }
            booksArray.append(id)
            userDefaults.set(booksArray, forKey: Keys.books.rawValue)
        } else {
            var booksArray: [String] = []
            booksArray.append(id)
            userDefaults.set(booksArray, forKey: Keys.books.rawValue)
        }
        
    }
    
    func get() -> [String] {
        userDefaults.array(forKey: Keys.books.rawValue) as? [String] ?? []
    }
    
    func clear() {
        userDefaults.set([], forKey: Keys.books.rawValue)
    }
    
    func isBookFavorite(id: String) -> Bool {
        let books = userDefaults.array(forKey: Keys.books.rawValue) as? [String] ?? []
        if books.contains(id) {
            return true
        }
        else {
            return false
        }
    }
    
    func delete(id: String) {
        guard var books = userDefaults.array(forKey: Keys.books.rawValue) as? [String] else { return }
        books.removeAll(where: { $0 == id })
        userDefaults.set(books, forKey: Keys.books.rawValue)
    }
}
