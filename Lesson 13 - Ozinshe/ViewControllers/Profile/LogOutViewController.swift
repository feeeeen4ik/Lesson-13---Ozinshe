//
//  LogOutViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 25.11.2025.
//

import UIKit
import SnapKit
import Localize_Swift

class LogOutViewController: UIViewController {
    
    lazy var container = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var topLabel = {
        let label = UILabel()
        
        label.text = "logOutSecondTitleLabel".localized()
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var confirmButton = {
        let button = UIButton()
        
        //настройка эффекта нажатия
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "7E2DFC")
        config.cornerStyle = .large
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer(
            { incoming in
                var outgoing = incoming
                
                outgoing.font = UIFont(name: "SFProDisplay-Bold", size: 16)
                outgoing.foregroundColor = .white
                
                return outgoing
            }
        )

        button.configuration = config
        button.configurationUpdateHandler = { btn in
            switch btn.state {
            case .highlighted:
                btn.alpha = 0.6
            default:
                btn.alpha = 1.0
            }
        }
        
        button.setTitle("profileConfirButton".localized(), for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        return button
    }()
    
    lazy var denyButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.cornerStyle = .large
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer(
            { incoming in
                var outgoing = incoming
                
                outgoing.font = UIFont(name: "SFProDisplay-Bold", size: 16)
                outgoing.foregroundColor = UIColor(named: "5415C6")
                
                return outgoing
            }
        )
        //настройка эффекта нажатия
        button.configuration = config
        button.configurationUpdateHandler = { btn in
            switch btn.state {
            case .highlighted:
                btn.alpha = 0.6
            default:
                btn.alpha = 1.0
            }
        }
        
        button.setTitle("profileDenyButton".localized(), for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(denied), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(updateLanguage),
                name: .languageChanged,
                object: nil
            )
        
        navigationItem.title = "logOutMainTitleLabel".localized()
        view.backgroundColor = UIColor(named: "FFFFFF")
        setupUI()
        
        //настройка высоты bottomSheet
        container.layoutIfNeeded()
        let heightView = container.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: UIView.layoutFittingCompressedSize.height)).height
        
        if let sheet = sheetPresentationController {
            sheet.detents = [ .custom { _ in heightView + 100} ]
            sheet.prefersGrabberVisible = true
        }
    }
    
    private func setupUI() {
        view.addSubview(container)
        
        container.addSubview(topLabel)
        container.addSubview(confirmButton)
        container.addSubview(denyButton)
        
        container.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        denyButton.snp.makeConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
    @objc private func logOut() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            let mainVC = LoginViewController()
            let navVC = UINavigationController(rootViewController: mainVC)
            
            window.rootViewController = navVC
            window.makeKeyAndVisible()
            
        }
    }
    
    @objc private func denied() {
        dismiss(animated: true)
    }
    
    @objc private func updateLanguage() {
        navigationItem.title = "logOutMainTitleLabel".localized()
        topLabel.text = "logOutSecondTitleLabel".localized()
        confirmButton.setTitle("profileConfirButton".localized(), for: .normal)
        denyButton.setTitle("profileDenyButton".localized(), for: .normal)
    }

}
