//
//  BooksService.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import Foundation
import RxSwift
import Alamofire

protocol BooksServiceProtocol {
    func searchBooks(by name: String) -> Single<SearchBookResponse>
    func fetchBook(by id: String) -> Single<Book>
}

enum BooksServiceError: Error {
    case badUrl
    case decodeError
    case apiError
}

final class BooksService: BooksServiceProtocol {
    static let shared = BooksService()
    private init() { }
    private lazy var httpService: HttpService = BooksHttpService()
    
    func searchBooks(by name: String) -> Single<SearchBookResponse> {
        return Single<SearchBookResponse>.create { [httpService] (single) -> Disposable in
            
            do {
                try BooksHttpRouter.searchBooks(term: name)
                    .request(using: httpService)
                    .responseJSON(completionHandler: { (response) in
                        guard let data = response.data else {
                            single(.failure(BooksServiceError.apiError))
                            return
                        }
                        
                        do {
                            let books = try JSONDecoder().decode(SearchBookResponse.self, from: data)
                            single(.success(books))
                        }
                        catch {
                            single(.failure(BooksServiceError.decodeError))
                        }
                    })
            }
            catch {
                single(.failure(BooksServiceError.apiError))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchBook(by id: String) -> Single<Book> {
        return Single<Book>.create { [httpService] (single) -> Disposable in
            
            do {
                try BooksHttpRouter.book(id: id)
                    .request(using: httpService)
                    .responseJSON(completionHandler: { (response) in
                        guard let data = response.data else {
                            single(.failure(BooksServiceError.apiError))
                            return
                        }
                        
                        do {
                            let book = try JSONDecoder().decode(Book.self, from: data)
                            single(.success(book))
                        }
                        catch {
                            single(.failure(BooksServiceError.decodeError))
                        }
                    })
            }
            catch {
                single(.failure(BooksServiceError.apiError))
            }
            
            return Disposables.create()
        }
    }
}
