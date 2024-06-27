//
//  UIViewExtentions.swift
//  IKDB
//
//  Created by Siros Taib on 6/25/24.
//

import Foundation
import UIKit

extension UIView {
    func roundX(_ radius: CGFloat = 10){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorderX(color: UIColor, width: CGFloat){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
