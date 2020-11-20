//
//  BookViewModel.swift
//  Books
//
//  Created by Admin on 20.11.2020.
//

import Foundation

final class BookViewModel {
    let id: String
    let title: String
    let description: String
    let imageUrl: String
    var isFavorite: Bool {
        booksFavoritesService.isBookFavorite(id: id)
    }
    
    private let booksFavoritesService: BooksFavoritesServiceProtocol
    
    init(book: Book, booksFavoritesService: BooksFavoritesServiceProtocol = BooksFavoritesService.shared) {
        self.id = book.id
        self.title = book.volumeInfo.title
        self.description = book.volumeInfo.bookDescription ?? "No Description"
        self.imageUrl = book.volumeInfo.imageLinks?.thumbnail ?? ""
        
        self.booksFavoritesService = booksFavoritesService
    }
    
    func swapFovoriteState() {
        if isFavorite {
            booksFavoritesService.delete(id: id)
        } else {
            booksFavoritesService.save(id: id)
        }
    }
}
