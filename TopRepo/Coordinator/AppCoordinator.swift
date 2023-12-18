//
//  AppCoordinator.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    var flowControllers: [FlowController] = []
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        if AuthManager.shared.isLoggedIn {
            self.openMainViewController()
        } else {
            self.openLoginViewController()
        }
        self.window.makeKeyAndVisible()
    }
    
    private func openMainViewController() {
        // Show Main view controller
        // it could be Main tabbar of the app
        // we can passing data in our flows
        
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        self.window.rootViewController = self.navigationController
        self.navigationController.setViewControllers([homeViewController], animated: true)
        
        homeViewController.openSettingsTapped = { [weak self] in
            self?.openSettingsViewController()
        }
    }
    
    private func openSettingsViewController() {
        let settingsController = SettingsViewController()
        self.navigationController.pushViewController(settingsController, animated: true)
    }
    
    private func openLoginViewController() {
        // Show the Login view controller and start its Flow
    }
}
