//
//  HomeViewModel.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class HomeViewModel {
    struct Input {
        let searchDriver: Driver<String>
    }
    
    struct Output {
        let books: Driver<[Book]>
        let title: Driver<String> = .just("Books")
    }
    
    private let booksRelay: BehaviorRelay<[Book]> = BehaviorRelay(value: [])
    private let loadingRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let bag = DisposeBag()
    
    private let booksService: BooksServiceProtocol
    private let booksFavoritesService: BooksFavoritesServiceProtocol
    
    let tappedBookmarkButton: PublishRelay<Book> = PublishRelay()
    
    init(
        booksService: BooksServiceProtocol = BooksService.shared,
        booksFavoritesService: BooksFavoritesServiceProtocol = BooksFavoritesService.shared
    ) {
        self.booksService = booksService
        self.booksFavoritesService = booksFavoritesService
    }
    
    func transfrom(input: Input) -> Output {
        input.searchDriver
            .debounce(.microseconds(300))
            .distinctUntilChanged()
            .skip(1)
            .map({ [loadBooks] in
                loadBooks($0)
            })
            .drive()
            .disposed(by: bag)
        
        tappedBookmarkButton
            .map({ [booksFavoritesService] in
                booksFavoritesService.save(id: $0.id)
            })
            .subscribe()
            .disposed(by: bag)
        
        let output = Output(
            books: booksRelay
                .share(replay: 1, scope: .whileConnected)
                .asDriver(onErrorJustReturn: [])
        )
        return output
    }
    
    private func loadBooks(by term: String) {
        if term != "" {
            booksService.searchBooks(by: term)
                .map({ $0.items })
                .map(booksRelay.accept)
                .map({ [loadingRelay] in loadingRelay.accept(true) })
                .subscribe()
                .disposed(by: bag)
        }
    }
}
