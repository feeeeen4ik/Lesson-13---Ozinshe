//
//  ChangePasswordViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 19.11.2025.
//

import UIKit
import SnapKit

class ChangePasswordViewController: UIViewController {

    lazy var upperView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
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
    
    let passwordTextField = UITextField()
    lazy var passwordView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        passwordTextField.placeholder = "Сіздің құпия сөзіңіз"
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.borderStyle = .none
        passwordTextField.textAlignment = .left
        passwordTextField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        
        
        let imagePassword = UIImageView()
        imagePassword.image = UIImage(named: "PasswordKey")
        imagePassword.contentMode = .scaleAspectFill
        imagePassword.clipsToBounds = true
        
        let showPasswordButton = UIButton()
        showPasswordButton
            .setImage(UIImage(named: "ShowPassword"), for: .normal)
        showPasswordButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        showPasswordButton.tag = 1
        
        view.addSubview(imagePassword)
        view.addSubview(passwordTextField)
        view.addSubview(showPasswordButton)
        
        imagePassword.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.width.equalTo(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(imagePassword.snp.trailing).offset(8)
            make.trailing.equalTo(showPasswordButton.snp.leading).offset(8)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    
        return view
    }()
    
    let copyPasswordTextField = UITextField()
    lazy var copyPasswordView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        copyPasswordTextField.placeholder = "Сіздің құпия сөзіңіз"
        copyPasswordTextField.keyboardType = .default
        copyPasswordTextField.isSecureTextEntry = true
        copyPasswordTextField.autocorrectionType = .no
        copyPasswordTextField.autocapitalizationType = .none
        copyPasswordTextField.borderStyle = .none
        copyPasswordTextField.textAlignment = .left
        copyPasswordTextField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        
        
        let imagePassword = UIImageView()
        imagePassword.image = UIImage(named: "PasswordKey")
        imagePassword.contentMode = .scaleAspectFill
        imagePassword.clipsToBounds = true
        
        let showPasswordButton = UIButton()
        showPasswordButton
            .setImage(UIImage(named: "ShowPassword"), for: .normal)
        showPasswordButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        showPasswordButton.tag = 2
        
        view.addSubview(imagePassword)
        view.addSubview(copyPasswordTextField)
        view.addSubview(showPasswordButton)
        
        imagePassword.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.width.equalTo(20)
        }
        
        copyPasswordTextField.snp.makeConstraints { make in
            make.leading.equalTo(imagePassword.snp.trailing).offset(8)
            make.trailing.equalTo(showPasswordButton.snp.leading).offset(8)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    
        return view
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
        
        setupUI()

    }
    
    private func setupUI() {
        view.addSubview(upperView)
        view.addSubview(passwordLabel)
        view.addSubview(passwordView)
        view.addSubview(copyPasswordLabel)
        view.addSubview(copyPasswordView)
        view.addSubview(applyPasswordButton)
        
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
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        copyPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        copyPasswordView.snp.makeConstraints { make in
            make.top.equalTo(copyPasswordLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        applyPasswordButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(42)
            make.height.equalTo(56)
        }
        
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
