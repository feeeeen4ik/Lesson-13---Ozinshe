//
//  CustomLabel.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 02.12.2025.
//

import UIKit

final class CustomLabel: UILabel {
    init(text: String, fontName: String, fontSize: Int, textColor: String, textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont(name: fontName, size: CGFloat(fontSize))
        self.textColor = UIColor(named: textColor)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
