//
//  HomeViewController.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var viewModel: HomeViewModel!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupBinding()
    }
    
    func configureViews() {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        
        self.navigationItem.searchController = searchController
        
        tableView.register(BookCell.nib, forCellReuseIdentifier: BookCell.identifier)
    }
    
    func setupBinding() {
        guard let searchBar = self.navigationItem.searchController?.searchBar else { return }
        let input = HomeViewModel.Input(searchDriver: searchBar.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transfrom(input: input)
        
        output.books
            .drive(tableView.rx.items(cellIdentifier: BookCell.identifier, cellType: BookCell.self), curriedArgument:({ [viewModel] _, book, cell in
                cell.configure(with: .init(book: book))
            }))
            .disposed(by: bag)
        
        output.title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        output.books
            .map({ $0.count != 0 })
            .drive(statusLabel.rx.isHidden)
            .disposed(by: bag)
        
        output.books
            .map({ $0.count == 0 })
            .drive(tableView.rx.isHidden)
            .disposed(by: bag)
    }
}

