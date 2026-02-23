//
//  MovieScreenshotCollectionViewCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 23.02.2026.
//

import UIKit
import Kingfisher
import SnapKit

class MovieScreenshotCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "MovieScreenshotCollectionViewCell"
    private let baseURLForImage = NetworkManager.baseURLForImage
    
    lazy var pictureImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
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
        
        pictureImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with imageId: Any) {

        let pictureURL = URL(string: "\(baseURLForImage)\(imageId)")
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
