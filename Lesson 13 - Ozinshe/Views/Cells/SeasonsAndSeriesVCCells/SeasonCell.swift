//
//  SeasonCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 03.03.2026.
//

import UIKit
import SnapKit


class SeasonCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "SeasonCell"
    
    lazy var seasonTitleLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = UIColor(named: "374151")
        label.textAlignment = .center
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            seasonTitleLabel.backgroundColor = isSelected ? UIColor(named: "9753F0") : UIColor(named: "F3F4F6")
            seasonTitleLabel.textColor = isSelected ? UIColor.white : UIColor(named: "374151")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(seasonTitleLabel)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        seasonTitleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureWith(seasonNumber: Int, isSelected: Bool)  {
        seasonTitleLabel.text = "\(seasonNumber) сезон"
        self.isSelected = isSelected
    }
}
