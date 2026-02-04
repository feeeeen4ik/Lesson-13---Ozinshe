//
//  HomeCollectionCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 03.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

class HomePopularCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "HomePopularCollectionCell"
    private let baseURLForImage = NetworkManager.baseURLForImage
    
    lazy var pictureImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var categoryLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = .white
        label.backgroundColor = UIColor(named: "7E2DFC")
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    
    lazy var containerForCategoryLabel = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "7E2DFC")
        view.layer.cornerRadius = 8
        
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.edges
                .equalToSuperview()
                .inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        }
        
        return view
    }()
    
    lazy var movieNameLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var movieDescriptionLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        label.numberOfLines = 2
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        containerForCategoryLabel.addSubview(categoryLabel)
        
        contentView.addSubview(pictureImageView)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieDescriptionLabel)
        contentView.addSubview(containerForCategoryLabel)
        
        pictureImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
        }
        
        containerForCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.top).offset(8)
            make.leading.equalTo(pictureImageView.snp.leading).offset(8)
            make.height.equalTo(24)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
        }
        
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: Movie) {
        categoryLabel.text = model.categories.first?.name
        movieNameLabel.text = model.name
        movieDescriptionLabel.text = model.description
        
        let pictureIndex = URL(string: model.poster.link)?.lastPathComponent ?? "0"
        let pictureURL = URL(string: "\(baseURLForImage)\(pictureIndex)")
        let processor = DownsamplingImageProcessor(
            size: pictureImageView.bounds
                .size)
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf
            .setImage(
                with: pictureURL,
                options: [
                    .processor(processor),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]
            ) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success:
                    break
                case .failure:
                    pictureImageView.image = UIImage(named: "ImageNotFound")
                }
            }
    }
}
