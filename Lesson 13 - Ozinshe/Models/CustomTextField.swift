//
//  CustomTextField.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 22.11.2025.
//

import UIKit

final class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func becomeFirstResponder() -> Bool {
        layer.borderColor = UIColor(named: "9753F0")?.cgColor
        layer.borderWidth = 1
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        layer.borderWidth = 1
        return super.resignFirstResponder()
    }
}
