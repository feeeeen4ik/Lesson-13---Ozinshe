//
//  CustomString.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 21.12.2025.
//

import Foundation

extension String {
    
    var checkValidateEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z0-9-]+"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
