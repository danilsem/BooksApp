//
//  SceneDelegate.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    let bag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let homeCoordinator = HomeCoordinator()
        let favoritesCoordinator = FavoritesCoordiantor()
        
        appCoordinator = AppCoordinator(window: window!, subModules: (
            homeCoordinator: homeCoordinator,
            favoritesCoordinator: favoritesCoordinator
        ))
        
        appCoordinator?.start()
    }
}

