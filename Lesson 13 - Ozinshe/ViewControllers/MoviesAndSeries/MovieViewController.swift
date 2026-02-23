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
    let networkManager = NetworkManager.shared
    
    
    lazy var scrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = true
        
        return scrollView
    }()
    
    lazy var contentView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F9FAFB")
        
        return view
    }()
    
    lazy var returnButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "returnButton"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(returnToMainVC), for: .touchUpInside)
        
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
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
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
    
    lazy var posterImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "ImageNotFound")
        image.isUserInteractionEnabled = true
        
        return image
    }()
    
    lazy var gradientForTopButtonsView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var movieDescriptionViewMainContainer = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F9FAFB")
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
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
    
    lazy var upperLineMovieDescriptionView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }()
    
    lazy var bottomLineMovieDescriptionView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
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
    
    lazy var movieDescriptionView = {
        let view = GradientMaskView()
        
        view.addSubviews(fullMovieDescriptionLabel)
        
        fullMovieDescriptionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var moreDescriptionButton = {
        let button = UIButton()
        
        button.setTitle("Толығырақ", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(showMoreDescription), for: .touchUpInside)
        
        return button
    }()
    
    lazy var directorLabel = {
        let label = UILabel()
        
        label.text = "Режиссер:"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "4B5563")
        
        return label
    }()
    
    lazy var directorNameLabel = {
        let label = UILabel()
        
        label.text = movie?.director
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var directorStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 19
        stack.alignment = .leading
        stack.addArrangedSubview(directorLabel)
        stack.addArrangedSubview(directorNameLabel)
        
        return stack
    }()
    
    lazy var producerLabel = {
        let label = UILabel()
        
        label.text = "Продюссер:"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "4B5563")
        
        return label
    }()
    
    lazy var producerNameLabel = {
        let label = UILabel()
        
        label.text = movie?.director
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var producerStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 19
        stack.alignment = .leading
        stack.addArrangedSubview(producerLabel)
        stack.addArrangedSubview(producerNameLabel)
        
        return stack
    }()
    
    lazy var screenshotsLabel = {
        let label = UILabel()
        
        label.text = "Скриншоттар"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827")
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var screenshotsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 184, height: 112)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        
        collectionView.register(MovieScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: "MovieScreenshotCollectionViewCell")
        
        return collectionView
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
        gradientLayerForTopButtons.frame = gradientForTopButtonsView.bounds
        gradientLayerForMovieDescription.frame = movieDescriptionView.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "F9FAFB")
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(gradientForTopButtonsView)
        contentView.addSubview(topButtonsStackView)
        contentView.addSubview(returnButton)
        contentView.addSubview(movieDescriptionViewMainContainer)
        
        movieDescriptionViewMainContainer.addSubview(movieNameLabel)
        movieDescriptionViewMainContainer.addSubview(movieShortDescriptionLabel)
        movieDescriptionViewMainContainer.addSubview(upperLineMovieDescriptionView)
        movieDescriptionViewMainContainer.addSubview(movieDescriptionView)
        movieDescriptionViewMainContainer.addSubview(moreDescriptionButton)
        movieDescriptionViewMainContainer.addSubview(directorStackView)
        movieDescriptionViewMainContainer.addSubview(producerStackView)
        movieDescriptionViewMainContainer.addSubview(bottomLineMovieDescriptionView)
        movieDescriptionViewMainContainer.addSubview(screenshotsLabel)
        movieDescriptionViewMainContainer.addSubview(screenshotsCollectionView)
        
        setupPoster()
        setupGradientForTopButtons()
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        returnButton.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top).offset(50)
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(40)
        }
        
        topButtonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(posterImageView).inset(48)
        }
        
        gradientForTopButtonsView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.top.equalTo(topButtonsStackView.snp.top)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        movieDescriptionViewMainContainer.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).inset(20)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
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
        
        upperLineMovieDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(movieShortDescriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        movieDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(upperLineMovieDescriptionView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        moreDescriptionButton.snp.makeConstraints { make in
            make.top.equalTo(movieDescriptionView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(22)
        }
        
        directorStackView.snp.makeConstraints { make in
            make.top.equalTo(moreDescriptionButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        producerStackView.snp.makeConstraints { make in
            make.top.equalTo(directorStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        bottomLineMovieDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(producerStackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        screenshotsLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomLineMovieDescriptionView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        screenshotsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(screenshotsLabel.snp.bottom).offset(16)
            make.height.equalTo(112)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
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
        gradientLayerForTopButtons.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayerForTopButtons.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayerForTopButtons.endPoint = CGPoint(x: 0.5, y: 1)
        gradientForTopButtonsView.layer.insertSublayer(gradientLayerForTopButtons, at: 0)
    }
    
    @objc private func returnToMainVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func showMoreDescription() {
        
        if fullMovieDescriptionLabel.numberOfLines == 5 {
            fullMovieDescriptionLabel.numberOfLines = 0
            movieDescriptionView.layer.mask = nil
            movieDescriptionView.setMaskEnabled(false)
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        } else {
            fullMovieDescriptionLabel.numberOfLines = 5
            movieDescriptionView.layer.mask = gradientLayerForMovieDescription
            movieDescriptionView.setMaskEnabled(true)
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func addToFavorite() {
        networkManager.addToFavoriteBy(id: movie!.id) { [weak self] error in
            guard let self else { return }
            
            if let error {
                print(error.localizedDescription)
                return
            }
        }
    }

}


extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movie?.screenshots.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieScreenshotCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! MovieScreenshotCollectionViewCell
        let imageId = movie?.screenshots[indexPath.row].fileId
        
        cell.configure(with: imageId ?? "ImageNotFound")
        
        return cell
    }

    
}
