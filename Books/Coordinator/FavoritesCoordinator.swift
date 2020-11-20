//
//  FavoritesCoordinator.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import UIKit

final class FavoritesCoordiantor: NavigationCoordinator {
    var navigator: NavigatorType
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UINavigationController
    
    private let favoritesViewController: FavoritesViewController
    
    init() {
        favoritesViewController = UIStoryboard.instantiateViewControllerFromMain(ofType: FavoritesViewController.self)
        let viewModel = FavoritesViewModel()
        favoritesViewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: favoritesViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        
    }
}
