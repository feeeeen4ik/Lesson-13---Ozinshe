//
//  UIView.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 02.12.2025.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView ...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
