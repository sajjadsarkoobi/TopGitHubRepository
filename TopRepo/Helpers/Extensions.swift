//
//  Extensions.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation
import UIKit

//MARK: -UIView
extension UIView {
    
    ///make view round or add corner radius by specifying the radius amount
    func round(radius: CGFloat = 0.0 ) {
        if radius > 0 {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = (self.frame.height/2)
        }
    }
}

//MARK: -UIImage
extension UIImage {
      func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

//MARK: -UIColor
extension UIColor {

    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1)
    }
}

//MARK: UIBUtton
extension UIButton {
    
    ///Default App button
    func setDefaultButton(title: String, backgroundColor: UIColor = AppColors.greenColor) {
        self.round(radius: 10)
        self.backgroundColor = backgroundColor
        self.setTitleColor(.white, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    func setTranslucentButton(title: String) {
        self.round(radius: 10)
        self.backgroundColor = .systemBackground
        self.setTitleColor(AppColors.greenColor, for: .normal)
        self.layer.borderColor = AppColors.greenColor.cgColor
        self.layer.borderWidth = 1.5
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.setTitle(title, for: .normal)
    }
}

//MARK: Encodable
extension Encodable {
    
    /// Encode into JSON and return `Data`
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}
