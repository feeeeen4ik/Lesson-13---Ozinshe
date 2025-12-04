//
//  ChangePasswordViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 19.11.2025.
//

import UIKit
import SnapKit

class ChangePasswordViewController: UIViewController {
    var buttonBottomConstraint: Constraint?
    
    lazy var upperView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "FFFFFF")
        
        return view
    }()
  
    lazy var passwordLabel = {
        let label = UILabel()
        
        label.text = "Password"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var copyPasswordLabel = {
        let label = UILabel()
        
        label.text = "Құпия сөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var passwordTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "Сіздің құпия сөзіңіз"
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
    
    lazy var imagePassword = {
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
            .addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        button.tag = 1
        
        return button
    }()
    
    lazy var copyPasswordTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "Сіздің құпия сөзіңіз"
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
    
    lazy var copyImagePassword = {
        let image = UIImageView()
        
        image.image = UIImage(named: "PasswordKey")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var copyShowPasswordButton = {
        let button = UIButton()
        
        button
            .setImage(UIImage(named: "ShowPassword"), for: .normal)
        button
            .addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        button.tag = 2
        
        return button
    }()
    
    
    lazy var applyPasswordButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 12
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(applyPassword), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        setupKeyboardObservers()
        setupUI()

    }
    
    private func setupUI() {
        view.addSubview(upperView)
        view.addSubview(passwordLabel)
        view.addSubview(copyPasswordLabel)
        view.addSubview(applyPasswordButton)
        view.addSubview(passwordTextField)
        view.addSubview(imagePassword)
        view.addSubview(showPasswordButton)
        view.addSubview(copyPasswordTextField)
        view.addSubview(copyImagePassword)
        view.addSubview(copyShowPasswordButton)
        
        upperView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().inset(0)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.height.equalTo(1)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.width.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        imagePassword.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(22)
            make.leading.equalToSuperview().inset(40)
            make.height.width.equalTo(20)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(22)
            make.trailing.equalToSuperview().inset(40)
            make.height.width.equalTo(20)
        }
        
        copyPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        copyPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(copyPasswordLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.width.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        copyImagePassword.snp.makeConstraints { make in
            make.top.equalTo(copyPasswordLabel.snp.bottom).offset(22)
            make.leading.equalToSuperview().inset(40)
            make.height.width.equalTo(20)
            
        }
        
        copyShowPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(copyPasswordLabel.snp.bottom).offset(22)
            make.trailing.equalToSuperview().inset(40)
            make.height.width.equalTo(20)
        }
        
        applyPasswordButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            buttonBottomConstraint = make.bottom
                .equalTo(view.safeAreaLayoutGuide)
                .inset(16).constraint
            make.height.equalTo(56)
        }
        
    }
    
    //отслеживание открытия/скрытия клавиатуры
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    
    //селектор для сдвига кнопки при открытии клавиатупы
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        buttonBottomConstraint?.update(offset: -keyboardFrame.height)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    //селектор для сдвига кнопки при скрытии клавиатупы
    @objc private func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        buttonBottomConstraint?.update(offset: -16)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func showPassword(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            passwordTextField.isSecureTextEntry = passwordTextField.isSecureTextEntry ? false : true
        default:
            copyPasswordTextField.isSecureTextEntry = copyPasswordTextField.isSecureTextEntry ? false : true
        }
    }
    
    @objc private func applyPassword() {
        navigationController?.popViewController(animated: true)
    }
}
