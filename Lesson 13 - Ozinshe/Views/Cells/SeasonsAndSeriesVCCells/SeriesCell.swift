//
//  SeriesCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 03.03.2026.
//

import UIKit
import SnapKit

class SeriesCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "SeriesCell"
    
    lazy var pictureImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ImageNotFound")
        
        return image
    }()
    
    lazy var seriesTitleLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "11827")
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var downLineView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(pictureImageView)
        contentView.addSubview(seriesTitleLabel)
        contentView.addSubview(downLineView)
        
        pictureImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        seriesTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(pictureImageView.snp.bottom).offset(8)
            make.height.equalTo(21)
        }
        
        downLineView.snp.makeConstraints { make in
            make.top.equalTo(seriesTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func configureWith(seasonNumber: Int)  {
        seriesTitleLabel.text = "\(seasonNumber) серия"
    }
}
