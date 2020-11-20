//
//  HomeCoordinator.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import UIKit

final class HomeCoordinator: NavigationCoordinator {
    var navigator: NavigatorType
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UINavigationController
    
    var homeViewController: HomeViewController
    
    init() {
        homeViewController = UIStoryboard.instantiateViewControllerFromMain(ofType: HomeViewController.self)
        let viewModel = HomeViewModel()
        homeViewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        
        
        
    }
}
