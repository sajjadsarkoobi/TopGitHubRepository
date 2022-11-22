//
//  Coordinator.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation
import UIKit

///Coordinator protocol
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var flowControllers: [FlowController] { get set }
    
    func start()
}

///Top View controllers should conform to Coordinating protocol
protocol Coordinating: AnyObject {
    var coordinator: Coordinator? { get set }
}

///Flow Controller protocol
protocol FlowController {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator { get set }
    func startFlow()
    func endFlow()
}
