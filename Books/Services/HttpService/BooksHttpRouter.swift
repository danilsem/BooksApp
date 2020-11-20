//
//  BooksHttpRouter.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import Foundation
import Alamofire

enum BooksHttpRouter: HttpRouter {
    case searchBooks(term: String)
    case book(id: String)
    
    var baseURL: String {
        "https://www.googleapis.com/"
    }
    
    var path: String {
        switch self {
        case .searchBooks:
            return "books/v1/volumes"
        case .book(let id):
            return "books/v1/volumes/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchBooks(let term):
            return [
                "q": "\(term)",
                "max_results": "10"
            ]
        case .book:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
