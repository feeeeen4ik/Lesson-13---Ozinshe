//
//  RegistrationViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 05.12.2025.
//

import UIKit
import SnapKit
import Localize_Swift
import SVProgressHUD

final class RegistrationViewController: BaseViewController {
    
    private let networkManager = NetworkManager.shared
    private let profileStorage = ProfileStorage.shared

    lazy var titleLabel: UILabel = CustomLabel(
        text: "regMainTitleLabel".localized(),
        fontName: "SFProDisplay-Bold",
        fontSize: 24,
        textColor: "111827",
        textAlignment: .left
    )
    
    lazy var secondTitleLabel: UILabel = CustomLabel(
        text: "regSecondTitleLabel".localized(),
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
        
        textField.placeholder = "regEmailTextFieldPlaceholder".localized()
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
    
    lazy var wrongEmailLabel = {
        let label = CustomLabel(
            text: "logInWrongEmailLabel".localized(),
            fontName: "SFProDisplay-Medium",
            fontSize: 14,
            textColor: "FF402B",
            textAlignment: .left)
        label.isHidden = true
        
        return label
    }()
    
    lazy var passwordLabel: UILabel = CustomLabel(
        text: "regInPasswordLabel".localized(),
        fontName: "SFProDisplay-Bold",
        fontSize: 14,
        textColor: "111827",
        textAlignment: .left
    )
    lazy var passwordTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "regInPasswordTextFieldPlaceholder".localized()
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.backgroundColor = UIColor(named: "TextFields")
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        
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
        button.tag = 1
        
        button
            .setImage(UIImage(named: "ShowPassword"), for: .normal)
        button
            .addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var secondPasswordLabel: UILabel = CustomLabel(
        text: "regInSecondPasswordLabel".localized(),
        fontName: "SFProDisplay-Bold",
        fontSize: 14,
        textColor: "111827",
        textAlignment: .left
    )
    lazy var secondPasswordTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "regInPasswordTextFieldPlaceholder".localized()
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.backgroundColor = UIColor(named: "TextFields")
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        
        return textField
    }()
    
    lazy var secondPasswordImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "PasswordKey")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var secondShowPasswordButton = {
        let button = UIButton()
        button.tag = 2
        
        button
            .setImage(UIImage(named: "ShowPassword"), for: .normal)
        button
            .addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var accountAlredyExistsLabel = {
        let label = CustomLabel(
            text: "regAccountAlreadyExistsLabel".localized(),
            fontName: "SFProDisplay-Bold",
            fontSize: 14,
            textColor: "FF402B",
            textAlignment: .left
        )
        label.isHidden = true
        
        return label
    }()
    
    lazy var regButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "7E2DFC")
        config.title = "regMainTitleLabel".localized()
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in
            var outgoing = incoming
            
            outgoing.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            outgoing.foregroundColor = .white
            
            return outgoing
        }
        
        button.configuration = config
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button
            .addTarget(
                self,
                action: #selector(authorizate),
                for: .touchUpInside
            )
        
        return button
    }()

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
                secondPasswordLabel,
                secondPasswordTextField,
                secondPasswordImage,
                secondShowPasswordButton,
                regButton,
                wrongEmailLabel,
                accountAlredyExistsLabel
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
        
        wrongEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(0)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(wrongEmailLabel.snp.bottom).offset(12)
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

        secondPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.leading.trailing.equalTo(passwordTextField)
            
        }
        
        secondPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(passwordTextField)
            make.height.equalTo(56)
        }
        
        secondPasswordImage.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordTextField.snp.top).offset(17)
            make.leading.equalTo(secondPasswordTextField.snp.leading).offset(16)
            make.height.width.equalTo(20)
        }
        
        secondShowPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordImage)
            make.trailing.equalTo(secondPasswordTextField.snp.trailing).inset(16)
            make.height.width.equalTo(20)
        }
        
        accountAlredyExistsLabel.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordTextField.snp.bottom).offset(31)
            make.leading.trailing.equalTo(passwordTextField)
            make.height.equalTo(0)
        }
        
        regButton.snp.makeConstraints { make in
            make.top.equalTo(accountAlredyExistsLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
    }
    
    @objc private func showPassword(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            passwordTextField.isSecureTextEntry = passwordTextField.isSecureTextEntry ? false : true
        default:
            secondPasswordTextField.isSecureTextEntry = secondPasswordTextField.isSecureTextEntry ? false : true
        }
    }
    
    @objc private func authorizate() {
        
        if emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || secondPasswordTextField.text?.isEmpty == true {
            showAlert(
                title: "emailAndPasswordFieldsIsEmptyTitle".localized(),
                message: "emailAndPasswordFieldsIsEmptyMassage".localized()
            )
            return
        }
        
        if passwordTextField.text != secondPasswordTextField.text {
            showAlert(
                title: "regPasswordIsDifferentTitle".localized(),
                message: "regPasswordIsDifferentMassage".localized()
            )
            return
        }
        
        let email = emailTextField.text ?? ""
        let checkedEmail = email.checkValidateEmail
        validateEmail(email)
        if checkedEmail == false {
            return
        }
        
        SVProgressHUD.show()
        networkManager
            .signUp(
                email: emailTextField.text!,
                password: passwordTextField.text!) { [unowned self] result in
                    switch result {
                    case .success(let response):
                        profileStorage.accessToken = response.accessToken
                        showAccountAlreadyExistsLabel(false)
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = scene.windows.first {
                            let mainVC = TabBarViewController()
                            let navVC = UINavigationController(rootViewController: mainVC)
                            
                            UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve) {
                                window.rootViewController = navVC
                                window.makeKeyAndVisible()
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        showAccountAlreadyExistsLabel(true)
                    }
                    SVProgressHUD.dismiss()
                }
    }
    
    private func validateEmail(_ email: String) {
        let isValid = email.checkValidateEmail
        
        wrongEmailLabel.isHidden = isValid
        emailTextField.layer.borderColor = isValid ? UIColor(
            named: "textFieldBorder"
        )?.cgColor : UIColor(named: "FF402B")?.cgColor
        
        wrongEmailLabel.snp.updateConstraints { make in
            make.height.equalTo(isValid ? 0 : 24)
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showAccountAlreadyExistsLabel(_ show: Bool) {
        accountAlredyExistsLabel.isHidden = !show
        accountAlredyExistsLabel.snp.updateConstraints { make in
            make.height.equalTo(show ? 22 : 0)
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    override func updateLanguage() {
        titleLabel.text = "regMainTitleLabel".localized()
        secondTitleLabel.text = "regSecondMainTitleLabel".localized()
        emailTextField.placeholder = "regEmailPlaceholder".localized()
        passwordLabel.text = "regInPasswordLabel".localized()
        passwordTextField.placeholder = "regInPasswordTextFieldPlaceholder".localized()
        secondPasswordLabel.text = "regInSecondPasswordLabel".localized()
        secondPasswordTextField.placeholder = "regInPasswordTextFieldPlaceholder".localized()
            .localized()
        regButton.setTitle("regMainTitleLabel".localized(), for: .normal)
    }

}
