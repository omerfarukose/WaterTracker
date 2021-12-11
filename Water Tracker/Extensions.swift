//
//  Extensions.swift
//  Water Tracker
//
//  Created by Ömer Faruk KÖSE on 11.12.2021.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
