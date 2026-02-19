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
    let gradientLayerForTopButtons = CAGradientLayer()
    let gradientLayerForMovieDescription = CAGradientLayer()
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
    
    lazy var addFavoriteLabel = {
        let label = UILabel()
        
        label.text = "Тізімге қосу"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var addToFavoriteStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(addToFavoriteButton)
        stackView.addArrangedSubview(addFavoriteLabel)
        
        return stackView
    }()
    
    lazy var shareButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "shareButton"), for: .normal)
        
        return button
    }()
    
    lazy var shareLabel = {
        let label = UILabel()
            
        label.text = "Бөлісу"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var shareStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(shareLabel)
        
        return stackView
    }()
    
    lazy var posterImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "ImageNotFound")
        
        return image
    }()
    
    lazy var gradientForTopButtonsView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var scrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear

        return scrollView
    }()
    
    lazy var movieDescriptionViewMainContainer = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F9FAFB")
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    lazy var movieNameLabel = {
        let label = UILabel()
        
        label.text = movie?.name
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var movieShortDescriptionLabel = {
        let label = UILabel()
        
        label.text = "\(movie?.year ?? 0) • \(movie?.genres[0].name ?? "") • \(movie?.timing ?? 0) мин."
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var lineMovieView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }()
    
    lazy var movieDescriptionView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var fullMovieDescriptionLabel = {
        let label = UILabel()
        
        label.text = movie?.description
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var topButtonsStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.spacing = 52
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(addToFavoriteStackView)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(shareStackView)
        
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupGradientForTopButtons()
        setupGradientForMovieDescription()
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
                gradientForTopButtonsView,
                scrollView,
                topButtonsStackView
            )
        
        scrollView.addSubview(movieDescriptionViewMainContainer)
        scrollView.addSubview(movieNameLabel)
        scrollView.addSubview(movieShortDescriptionLabel)
        scrollView.addSubview(lineMovieView)
        scrollView.addSubview(movieDescriptionView)
        
        movieDescriptionView.addSubview(fullMovieDescriptionLabel)
        
        setupPoster()
        
        movieDescriptionViewMainContainer.snp.makeConstraints { make in
            make.leading.trailing.width.height.equalTo(scrollView)
        }
        
        fullMovieDescriptionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(24)
        }
        
        movieShortDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(8)
        }
        
        lineMovieView.snp.makeConstraints { make in
            make.top.equalTo(movieShortDescriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        movieDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(lineMovieView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
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
        
        gradientForTopButtonsView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.top).offset(30)
            make.top.equalTo(topButtonsStackView.snp.top)
        }
    }
    
    private func setupPoster() {
        let pictureIndex = URL(string: movie?.poster.link ?? "0")?.lastPathComponent ?? "0"
        let pictureURL = URL(string: "\(baseURLForImage)\(pictureIndex)")
        let processor = DownsamplingImageProcessor(
            size: posterImageView.bounds
                .size)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(
            with: pictureURL,
            options: [.processor(processor), .transition(.fade(1)), .cacheOriginalImage]
        ) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success:
                    break
                case .failure:
                    posterImageView.image = UIImage(named: "ImageNotFound")
                }
            }
    }
    
    private func setupGradientForTopButtons() {
        gradientLayerForTopButtons.frame = gradientForTopButtonsView.bounds
        gradientLayerForTopButtons.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayerForTopButtons.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayerForTopButtons.endPoint = CGPoint(x: 0.5, y: 1)
        gradientForTopButtonsView.layer.insertSublayer(gradientLayerForTopButtons, at: 0)
    }
    
    private func setupGradientForMovieDescription() {
        gradientLayerForMovieDescription.frame = movieDescriptionView.bounds
        gradientLayerForMovieDescription.colors = [
            UIColor(named: "F9FAFB")?.cgColor ?? UIColor.systemBackground.cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayerForMovieDescription.locations = [0.6, 1]
        gradientLayerForMovieDescription.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayerForMovieDescription.endPoint = CGPoint(x: 0.5, y: 1)
        movieDescriptionView.layer.mask = gradientLayerForMovieDescription
    }
    
    @objc private func returnToMainVC() {
        navigationController?.popViewController(animated: true)
    }

}
