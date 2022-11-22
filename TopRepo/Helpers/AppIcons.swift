//
//  AppIcons.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 10.11.2022.
//

import Foundation
import UIKit

final class AppIcons {
    
    static var star: UIImage {
        get {
            return UIImage(named: "star") ?? UIImage()
        }
    }
    
    static var starFilled: UIImage {
        get {
            return UIImage(named: "starFilled") ?? UIImage()
        }
    }
}
