//
//  MovieViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 16.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieViewController: UIViewController {
    
    var movie: Movie?
    let baseURLForImage = NetworkManager.baseURLForImage
    lazy var returnButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "returnButton"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget( self, action: #selector(returnToMainVC), for: .touchUpInside)
        
        return button
    }()
    
    lazy var playButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "playButton"), for: .normal)
        
        return button
    }()
    
    lazy var addToFavoriteButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "addToFavoriteButton"), for: .normal)
        
        return button
    }()
    
    lazy var shareButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "shareButton"), for: .normal)
        
        return button
    }()
    
    lazy var posterImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "ImageNotFound")
        
        return image
    }()
    
    lazy var gradientView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var scrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear

        return scrollView
    }()
    
    lazy var movieDscriptionView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F9FAFB")
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        return view
    }()
    
    lazy var topButtonsStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 52
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(addToFavoriteButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(shareButton)
        
        return stackView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        view.addSubviews(
                posterImageView,
                returnButton,
                scrollView,
                topButtonsStackView
            )
        scrollView.addSubview(movieDscriptionView)
        
        let pictureIndex = URL(
            string: movie?.poster.link ?? "0"
        )?.lastPathComponent ?? "0"
        let pictureURL = URL(string: "\(baseURLForImage)\(pictureIndex)")
        let processor = DownsamplingImageProcessor(
            size: posterImageView.bounds
                .size)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf
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
                    posterImageView.image = UIImage(named: "ImageNotFound")
                }
            }
    
        movieDscriptionView.snp.makeConstraints { make in
            make.leading.trailing.width.height.equalTo(scrollView)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.width * 0.80)
        }
        
        topButtonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        returnButton.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top).offset(60)
            make.leading.equalToSuperview().offset(25)
            make.height.width.equalTo(40)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(-30)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    @objc private func returnToMainVC() {
        navigationController?.popViewController(animated: true)
    }

}
