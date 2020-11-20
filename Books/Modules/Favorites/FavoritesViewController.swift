//
//  FavoritesViewController.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    private lazy var refreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.translatesAutoresizingMaskIntoConstraints = false
        refreshControll.tintColor = .systemPink
        refreshControll.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        return refreshControll
    }()
    
    var viewModel: FavoritesViewModel!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.refreshFavoriteBooks()
    }
    
    func configureViews() {
        tableView.register(BookCell.nib, forCellReuseIdentifier: BookCell.identifier)
        tableView.refreshControl = refreshControll
        
        self.navigationItem.title = "Favorites"
    }
    
    func setupBinding() {
        let input = FavoritesViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.books
            .drive(tableView.rx.items(cellIdentifier: BookCell.identifier, cellType: BookCell.self), curriedArgument: { _, book, cell in
                cell.configure(with: .init(book: book))
            })
            .disposed(by: bag)
        
        output.loadingIndicator
            .drive(loadingIndicator.rx.isAnimating)
            .disposed(by: bag)
    }
    
    @objc func onRefresh() {
        viewModel.refreshFavoriteBooks()
        refreshControll.endRefreshing()
    }
}
