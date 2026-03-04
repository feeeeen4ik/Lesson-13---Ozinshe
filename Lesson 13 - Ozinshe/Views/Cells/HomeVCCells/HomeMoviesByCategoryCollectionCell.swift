//
//  HomeMoviesByCategoryCollectionCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 12.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

class HomeMoviesByCategoryCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "HomeMoviesByCategoryCollectionCell"
    private let baseURLForImage = NetworkManager.baseURLForImage
    
    lazy var pictureImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var movieNameLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var movieCategoryLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        label.textAlignment = .left
        
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
        
        contentView.addSubview(pictureImageView)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieCategoryLabel)
        
        pictureImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(155)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        movieCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: Movie) {
        movieNameLabel.text = model.name
        movieCategoryLabel.text = model.categories.first?.name ?? ""
        
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
