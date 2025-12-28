//
//  FavoriteTableViewCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 11.11.2025.
//

import UIKit
import SnapKit
import SDWebImage
import Kingfisher

final class FavoriteTableViewCell: UITableViewCell {
    
    private let baseURLForImage = NetworkManager.baseURLForImage
    static let identifier: String = "FavoriteTableViewCell"
    
    lazy var pictureImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    lazy var titleLable = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var subtitleLable = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var playView = {
        let view = UIView()
        let imageView = UIImageView()
        let label = UILabel()
        
        view.backgroundColor = UIColor(named: "F8EEFF")
        view.layer.cornerRadius = 8
        
        imageView.image = UIImage(named: "Play Filled")
        
        label.text = "Қарау"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 10)
        label.textColor = UIColor(named: "9753F0")
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(12)
            make.size.equalTo(16)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.trailing.equalToSuperview().inset(12)
            make.leading.equalTo(imageView.snp.trailing).offset(6)
        }
    
        return view
    }()
    
    lazy var bottomView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Movie) {
        titleLable.text = model.name
        subtitleLable.text = "\(model.year) "
        model.genres.forEach { subtitleLable.text?.append("• \($0.name) ") }
        let pictureIndex = URL(string: model.poster.link)?.lastPathComponent ?? "0"
        let pictureURL = URL(string: "\(baseURLForImage)\(pictureIndex)")
        let processor = DownsamplingImageProcessor(
            size: pictureImageView.bounds
                .size)
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf
            .setImage(
                with: pictureURL,
                placeholder: UIImage(named: "ImageNotFound"),
                options: [
                    .processor(processor),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]
            )
    }
    
    private func setupUI() {
        contentView.addSubview(pictureImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(subtitleLable)
        contentView.addSubview(playView)
        contentView.addSubview(bottomView)
        contentView.backgroundColor = UIColor(named: "FFFFFF")
        
        pictureImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(280)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(24)
        }
        
        subtitleLable.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(8)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(24)
        }
        
        playView.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(17)
            make.top.equalTo(subtitleLable.snp.bottom).offset(24)
            make.trailing.equalToSuperview().inset(182)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
}
