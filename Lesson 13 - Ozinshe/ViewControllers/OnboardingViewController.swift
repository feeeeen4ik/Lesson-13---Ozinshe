//
//  OnboardingViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 09.12.2025.
//

import UIKit
import Localize_Swift
import SnapKit

class OnboardingViewController: BaseViewController, UIScrollViewDelegate {
    
    let pages: [(image: String, title: String, text: String)] = [
        (
            "Onboarding1",
            "onboardingMainTitle".localized(),
            "onboardingTextFirst".localized()
        ),
        (
            "Onboarding2",
            "onboardingMainTitle".localized(),
            "onboardingTextSecond".localized()
        ),
        (
            "Onboarding3",
            "onboardingMainTitle".localized(),
            "onboardingTextThird".localized()
        )
    ]
    
    lazy var pagesStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var skipButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.filled()
        config.title = "onbordingSkipButtonTitle".localized()
        config.cornerStyle = .large
        config.baseBackgroundColor = UIColor(named: "F9FAFB")
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer(
            { incoming in
                var outgoing = incoming
                
                outgoing.font = UIFont(name: "SFProDisplay-Medium", size: 12)
                outgoing.foregroundColor = UIColor(named: "111827")
                
                return outgoing
            }
        )
        
        button.configuration = config
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        button.configurationUpdateHandler = { button in
            switch button.state {
            case .highlighted:
                button.alpha = 0.6
            default:
                button.alpha = 1
            }
        }
        
        return button
    }()
    
    lazy var continueButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("onbordingButtonTitle".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var scrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        
        return scrollView
    }()
    
    lazy var normalDot = makeDotImage(width: 8, height: 8)
    lazy var currentDot = makeDotImage(width: 20, height: 8)
    
    lazy var pageControl = {
        let control = UIPageControl()
        
        control.currentPageIndicatorTintColor = UIColor(named: "B376F7")
        control.pageIndicatorTintColor = UIColor(named: "4B5563")
        control.currentPage = 0
        control.numberOfPages = pages.count
        control.preferredCurrentPageIndicatorImage = UIImage()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.preferredIndicatorImage = normalDot
        control.setIndicatorImage(currentDot, forPage: 0)
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(scrollView, pageControl, skipButton, continueButton)
        scrollView.addSubview(pagesStackView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pagesStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.snp.edges)
            make.height.equalTo(scrollView)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(152)
            make.centerX.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(24)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        for page in pages {
            let pageView = createPage(imageName: page.image, mainTitle: page.title, text: page.text)
            
            pagesStackView.addArrangedSubview(pageView)
            
            pageView.snp.makeConstraints { make in
                make.width.equalTo(scrollView.snp.width)
            }
        }
    }
    
    private func createPage(imageName: String, mainTitle: String, text: String) -> UIView {
        let container = UIView()
        
        let imageTop = UIImageView()
        imageTop.image = UIImage(named: imageName)
        imageTop.contentMode = .scaleAspectFill
        imageTop.clipsToBounds = true
        imageTop.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = mainTitle
        titleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "111827")
        titleLabel.numberOfLines = 0
        
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor(named: "6B7280")
        textLabel.numberOfLines = 4
            
        container.addSubview(imageTop)
        container.addSubview(titleLabel)
        container.addSubview(textLabel)
        
        imageTop.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(504)
            make.width.equalTo(400)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageTop.snp.top).offset(520)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
        }
        
        return container
    }
    
    @objc private func continueButtonTapped() {
        navigationController?
            .pushViewController(LoginViewController(), animated: true)
    }
    
    private func makeDotImage(width: CGFloat, height: CGFloat) -> UIImage {

        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: size)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: height / 2)
            path.fill()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        guard width > 0 else {
            return
        }
        
        let page = Int(
            round(scrollView.contentOffset.x / width)
        )
        
        if pageControl.currentPage != page {
            pageControl.currentPage = page
        }
        
        for index in 0..<pageControl.numberOfPages {
            let image = index == page ? currentDot : normalDot
            pageControl.setIndicatorImage(image, forPage: index)
        }
        
        skipButton.isHidden = page == pages.count - 1 ? true : false
        continueButton.isHidden = page != pages.count - 1 ? true : false
    }
    
}
