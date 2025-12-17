//
//  RegLoginViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 02.12.2025.
//

import UIKit
import SnapKit
import Localize_Swift

class LoginViewController: BaseViewController {

    lazy var titleLabel: UILabel = CustomLabel(
        text: "logInMainTitleLabel".localized(),
        fontName: "SFProDisplay-Bold",
        fontSize: 24,
        textColor: "111827",
        textAlignment: .left
    )
    
    lazy var secondTitleLabel: UILabel = CustomLabel(
        text: "logInSecondTitleLabel".localized(),
        fontName: "SFProDisplay-Medium",
        fontSize: 16,
        textColor: "9CA3AF",
        textAlignment: .left
    )
    
    lazy var emailLabel: UILabel = CustomLabel(
        text: "Email",
        fontName: "SFProDisplay-Bold",
        fontSize: 14,
        textColor: "111827",
        textAlignment: .left
    )
    
    lazy var emailTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "logInEmailTextFieldPlaceholder".localized()
        textField.keyboardType = .emailAddress
        textField.textAlignment = .left
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textContentType = .emailAddress
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.backgroundColor = UIColor(named: "TextFields")
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    lazy var emailImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "Email")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var passwordLabel: UILabel = CustomLabel(
        text: "logInPasswordLabel".localized(),
        fontName: "SFProDisplay-Bold",
        fontSize: 14,
        textColor: "111827",
        textAlignment: .left
    )
    lazy var passwordTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "logInPasswordTextFieldPlaceholder".localized()
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.backgroundColor = UIColor(named: "TextFields")
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    lazy var passwordImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "PasswordKey")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var showPasswordButton = {
        let button = UIButton()
        
        button
            .setImage(UIImage(named: "ShowPassword"), for: .normal)
        button
            .addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        return button
    }()
    
    lazy var authButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "7E2DFC")
        config.title = "logInAuthTitleButton".localized()
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in
            var outgoing = incoming
            
            outgoing.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            outgoing.foregroundColor = .white
            
            return outgoing
        }
        
        button.configuration = config
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(auth), for: .touchUpInside)
        
        return button
    }()
    
    lazy var createAccauntStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.addArrangedSubview(createAccauntLabel)
        stack.addArrangedSubview(createAccauntButton)
        
        return stack
    }()
    
    lazy var createAccauntButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.title = "createAccauntTitleButton".localized()
        button.configurationUpdateHandler = { btn in
            switch btn.state {
            case .highlighted:
                btn.titleLabel?.alpha = 0.6
            default:
                btn.titleLabel?.alpha = 1.0
            }
        }
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in
            var outgoing = incoming
            
            outgoing.font = UIFont(name: "SFProDisplay-Bold", size: 14)
            outgoing.foregroundColor = UIColor(named: "B376F7")
            
            return outgoing
        }
        
        button.configuration = config
        button.layer.borderWidth = 0
        button
            .addTarget(
                self,
                action: #selector(createAccaunt),
                for: .touchUpInside
            )
        
        return button
    }()
    
    lazy var createAccauntLabel: UILabel = CustomLabel(
        text: "logInCreateAccauntLabel".localized(),
        fontName: "SFProDisplay-Medium",
        fontSize: 14,
        textColor: "9CA3AF",
        textAlignment: .left
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF")
        
        setupUI()

    }
    
    func setupUI() {
        view
            .addSubviews(
                titleLabel,
                secondTitleLabel,
                emailLabel,
                emailTextField,
                emailImage,
                passwordLabel,
                passwordTextField,
                passwordImage,
                showPasswordButton,
                authButton,
                createAccauntStack
            )
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        secondTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(secondTitleLabel.snp.bottom).offset(29)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(56)
        }
        
        emailImage.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(22)
            make.leading.equalToSuperview().inset(40)
            make.height.width.equalTo(20)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.leading.trailing.equalTo(emailTextField)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(56)
        }
        
        passwordImage.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(22)
            make.leading.equalToSuperview().inset(40)
            make.height.width.equalTo(20)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(22)
            make.trailing.equalToSuperview().inset(40)
            make.height.width.equalTo(20)
        }
        
        authButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        createAccauntStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(authButton.snp.bottom).offset(24)
        }
        
    }
    
    @objc private func showPassword() {
        passwordTextField.isSecureTextEntry = passwordTextField.isSecureTextEntry ? false : true
    }
    
    @objc private func createAccaunt() {
        let VC = RegistrationViewController()
        
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @objc private func auth() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            let mainVC = TabBarViewController()
            let navVC = UINavigationController(rootViewController: mainVC)
            
            UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve) {
                window.rootViewController = navVC
                window.makeKeyAndVisible()
            }
        }
    }
    
    override func updateLanguage() {
        titleLabel.text = "logInMainTitleLabel".localized()
        secondTitleLabel.text = "logInSecondTitleLabel".localized()
        emailTextField.placeholder = "logInEmailPlaceholder".localized()
        passwordLabel.text = "logInPasswordLabel".localized()
        passwordTextField.placeholder = "logInPasswordPlaceholder".localized()
        authButton.setTitle( "logInAuthButton".localized(), for: .normal)
        createAccauntLabel.text = "logInCreateAccauntLabel".localized()
        createAccauntButton.setTitle( "logInCreateAccauntButton".localized(), for: .normal)
    }
}
