//
//  FavoritesViewModel.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class FavoritesViewModel {
    struct Input {
        
    }
    
    struct Output {
        let books: Driver<[Book]>
        let loadingIndicator: Driver<Bool>
    }
    
    private let favoriteBooksRelay: BehaviorRelay<[Book]> = BehaviorRelay(value: [])
    private let loadingRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    private let bag = DisposeBag()
    
    private let booksService: BooksServiceProtocol
    private let booksFavoritesService: BooksFavoritesServiceProtocol
    
    init(
        booksService: BooksServiceProtocol = BooksService.shared,
        booksFavoritesService: BooksFavoritesServiceProtocol = BooksFavoritesService.shared
    ) {
        self.booksService = booksService
        self.booksFavoritesService = booksFavoritesService
    }
    
    func transform(input: Input) -> Output {
        return Output(
            books: favoriteBooksRelay.asDriver(onErrorJustReturn: []),
            loadingIndicator: loadingRelay.asDriver(onErrorJustReturn: false)
        )
    }
    
    func getFavoritesBooks() {
        Observable.from(booksFavoritesService.get())
            .map({ [loadingRelay] in
                loadingRelay.accept(true)
                return $0
            })
            .map({ [booksService] in
                booksService.fetchBook(by: $0)
                    .asObservable()

            })
            .concat()
            .map({ [favoriteBooksRelay, loadingRelay] in
                favoriteBooksRelay.accept(favoriteBooksRelay.value + [$0])
                loadingRelay.accept(false)
            })
            .subscribe()
            .disposed(by: bag)
    }
    
    func refreshFavoriteBooks() {
        favoriteBooksRelay.accept([])
        Observable.from(booksFavoritesService.get())
            .map({ [loadingRelay] in
                loadingRelay.accept(true)
                return $0
            })
            .map({ [booksService] in
                booksService.fetchBook(by: $0)
                    .asObservable()

            })
            .concat()
            .map({ [favoriteBooksRelay, loadingRelay] in
                favoriteBooksRelay.accept(favoriteBooksRelay.value + [$0])
                loadingRelay.accept(false)
            })
            .subscribe()
            .disposed(by: bag)
    }
}
