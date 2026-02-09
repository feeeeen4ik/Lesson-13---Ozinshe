//
//  HomeSectionHeaderView.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 04.02.2026.
//

import UIKit
import SnapKit

class HomeSectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            label.textColor = UIColor(named: "111827")
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
        
        required init?(coder: NSCoder) { fatalError() }
        
        func configure(title: String) {
            titleLabel.text = title
        }
}
