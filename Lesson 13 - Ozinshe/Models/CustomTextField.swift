//
//  CustomTextField.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 22.11.2025.
//

import UIKit

final class CustomTextField: UITextField {
    
    // настройки отступов в поле ввода текста
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
    
    //установка цвета бордера при активации полля для ввода текста
    override func becomeFirstResponder() -> Bool {
        layer.borderColor = UIColor(named: "9753F0")?.cgColor
        layer.borderWidth = 1
        return super.becomeFirstResponder()
    }
    
    //установка цвета бордера для поля ввода в статичном режиме
    override func resignFirstResponder() -> Bool {
        layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        layer.borderWidth = 1
        return super.resignFirstResponder()
    }
}
