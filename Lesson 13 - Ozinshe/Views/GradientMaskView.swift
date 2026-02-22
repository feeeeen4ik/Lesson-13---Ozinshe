//
//  GradientMaskView.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 20.02.2026.
//

import UIKit

final class GradientMaskView: UIView {

    private let maskLayer = CAGradientLayer()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupMask()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupMask()
        }

        private func setupMask() {
            maskLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
            maskLayer.locations = [0.6, 1.0]
            maskLayer.startPoint = CGPoint(x: 0.5, y: 0)
            maskLayer.endPoint = CGPoint(x: 0.5, y: 1)
            self.layer.mask = maskLayer
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            maskLayer.frame = bounds
            CATransaction.commit()
        }
        
        func setMaskEnabled(_ enabled: Bool) {
            self.layer.mask = enabled ? maskLayer : nil
        }
    
}
