//
//  HomeGenresCollectionCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 09.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

final class HomeGenresCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "HomeGenreCollectionCell"
    private let baseURLForImage = NetworkManager.baseURLForImage
    
    lazy var pictureImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var genreNameLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        
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
        contentView.addSubview(genreNameLabel)
        
        pictureImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        genreNameLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func configure(with genre: Genre) {
        genreNameLabel.text = genre.name
        
        let pictureID = genre.fileId
        let pictureURL = URL(string: "\(baseURLForImage)\(pictureID)")
        let processor = DownsamplingImageProcessor(
            size: pictureImageView.bounds.size
        )
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
