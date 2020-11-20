//
//  AppCoordinator.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import UIKit

final class AppCoordinator: PresentationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController = UITabBarController()
    
    private let window: UIWindow
    
    typealias Submodules = (
        homeCoordinator: HomeCoordinator,
        favoritesCoordinator: FavoritesCoordiantor
    )
    
    init(window: UIWindow, subModules: Submodules) {
        self.window = window
        let homeCoordinator = subModules.homeCoordinator
        let favoritesCoordinator = subModules.favoritesCoordinator
        
        homeCoordinator.rootViewController.tabBarItem.title = "Search"
        
        homeCoordinator.rootViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        favoritesCoordinator.rootViewController.tabBarItem.title = "Favorites"
        favoritesCoordinator.rootViewController.tabBarItem.image = UIImage(systemName: "star")
        
        addChildCoordinator(homeCoordinator)
        addChildCoordinator(favoritesCoordinator)
        
        homeCoordinator.start()
        favoritesCoordinator.start()
        
        rootViewController.viewControllers = [
            homeCoordinator.rootViewController,
            favoritesCoordinator.rootViewController
        ]
    }
    
    func start() {

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
