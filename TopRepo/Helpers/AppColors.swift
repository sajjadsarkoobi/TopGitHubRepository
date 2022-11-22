//
//  AppColors.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 10.11.2022.
//

import Foundation
import UIKit

final class AppColors {
    
    static var yellowColor: UIColor {
        get {
            UIColor(named: "yellowColor") ?? .black
        }
    }
    
    static var greenColor: UIColor {
        get {
            UIColor(named: "greenColor") ?? .black
        }
    }
    
    static var backGroundPopUp: UIColor {
        get {
            UIColor(named: "backGroundPopUp") ?? .black
        }
    }
    
    static var gradientLightGrey: UIColor {
        get {
            UIColor(named: "gradientLightGrey") ?? .black
        }
    }
    
    static var gradientDarkGrey: UIColor {
        get {
            UIColor(named: "gradientLightGrey") ?? .black
        }
    }
}
