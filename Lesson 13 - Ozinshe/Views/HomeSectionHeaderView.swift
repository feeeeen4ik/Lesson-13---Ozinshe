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
    
    var tapHandler: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var seeAllButton = {
        let button = UIButton()
        
        button.setTitle("Барлығы", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(seeAllButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(title: String, isButtonHiden: Bool = true) {
        titleLabel.text = title
        seeAllButton.isHidden = isButtonHiden
    }
    
    @objc private func buttonTapped() {
        tapHandler?()
    }
}
