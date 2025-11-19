//
//  ProfileViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    lazy var logoutButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "LogOut"), for: .normal)
        
        return button
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        
        label.text = "Профиль"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827")
            
        return label
    }()
    
    lazy var topView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    lazy var profileImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "ProfileImage1")
        
        return image
    }()
    
    lazy var myProfileTitleLabel = {
        let label = UILabel()
        
        label.text = "Менің профилім"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var emailLabel = {
        let label = UILabel()
        
        label.text = "any@gmail.com"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    //MARK: profile view
    let themeStyleSwitch = UISwitch()
    let profileInfoButton = UIButton()
    let changePasswordButton = UIButton()
    let changeLanguageButton = UIButton()
    let themeStyleLabel = UILabel()
    let profileInfoView = UIView()
    let changePasswordView = UIView()
    let changeLanguageView = UIView()
    
    lazy var settingsView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "F9FAFB")
        
        //MARK: profile info
        profileInfoButton.setTitle("Жеке деректер", for: .normal)
        profileInfoButton.setTitleColor(UIColor(named: "1C2431"), for: .normal)
        profileInfoButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        profileInfoButton.contentHorizontalAlignment = .left
        profileInfoButton.addTarget(self, action: #selector(profileInfoTapped), for: .touchUpInside)
        
        let profileTextLabel = UILabel()
        profileTextLabel.text = "Өңдеу"
        profileTextLabel.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        profileTextLabel.textColor = UIColor(named: "9CA3AF")
        
        let profileButtonSymbolImage = UIImageView()
        profileButtonSymbolImage.image = UIImage(named: "ChevronRight")
        
        profileInfoView.backgroundColor = UIColor(named: "D1D5DB")
        
        view.addSubview(profileInfoButton)
        view.addSubview(profileTextLabel)
        view.addSubview(profileButtonSymbolImage)
        view.addSubview(profileInfoView)
        
        profileInfoButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalTo(profileTextLabel.snp.leading)
        }
        
        profileTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileInfoButton.snp.trailing).offset(145)
            make.centerY.equalTo(profileInfoButton)
            make.width.equalTo(39)
        }
        
        profileButtonSymbolImage.snp.makeConstraints { make in
            make.leading.equalTo(profileTextLabel.snp.trailing).offset(14)
            make.height.width.equalTo(16)
            make.trailing.equalToSuperview().offset(0)
            make.centerY.equalTo(profileTextLabel)
        }
        
        profileInfoView.snp.makeConstraints { make in
            make.top.equalTo(profileInfoButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(1)
            
        }
        
        //MARK: change password
        changePasswordButton.setTitle("Құпия сөзді өзгерту", for: .normal)
        changePasswordButton.setTitleColor(UIColor(named: "1C2431"), for: .normal)
        changePasswordButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        changePasswordButton.contentHorizontalAlignment = .left
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        
        let changePasswordSymbolImage = UIImageView()
        changePasswordSymbolImage.image = UIImage(named: "ChevronRight")
        
        changePasswordView.backgroundColor = UIColor(named: "D1D5DB")
        
        view.addSubview(changePasswordButton)
        view.addSubview(changePasswordSymbolImage)
        view.addSubview(changePasswordView)
        
        changePasswordButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.equalTo(profileInfoView).offset(20)
            make.trailing.equalTo(changePasswordSymbolImage.snp.leading)
        }
        
        changePasswordSymbolImage.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.trailing.equalToSuperview().offset(0)
            make.centerY.equalTo(changePasswordButton)
        }
        
        changePasswordView.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(1)
            
        }
        
        //MARK: change language
        changeLanguageButton.setTitle("Тіл", for: .normal)
        changeLanguageButton.setTitleColor(UIColor(named: "1C2431"), for: .normal)
        changeLanguageButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        changeLanguageButton.contentHorizontalAlignment = .left
        
        let changeLanguageLabel = UILabel()
        changeLanguageLabel.text = "Қазақша"
        changeLanguageLabel.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        changeLanguageLabel.textColor = UIColor(named: "9CA3AF")
        
        let changeLanguageSymbolImage = UIImageView()
        changeLanguageSymbolImage.image = UIImage(named: "ChevronRight")
        
        changeLanguageView.backgroundColor = UIColor(named: "D1D5DB")
        
        view.addSubview(changeLanguageButton)
        view.addSubview(changeLanguageLabel)
        view.addSubview(changeLanguageSymbolImage)
        view.addSubview(changeLanguageView)
        
        changeLanguageButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.equalTo(changePasswordView.snp.bottom).offset(20)
            make.trailing.equalTo(changeLanguageLabel.snp.leading)
        }
        
        changeLanguageLabel.snp.makeConstraints { make in
            make.leading.equalTo(changeLanguageButton.snp.trailing).offset(145)
            make.centerY.equalTo(changeLanguageButton)
            make.width.equalTo(53)
        }
        
        changeLanguageSymbolImage.snp.makeConstraints { make in
            make.leading.equalTo(changeLanguageLabel.snp.trailing).offset(14)
            make.height.width.equalTo(16)
            make.trailing.equalToSuperview().offset(0)
            make.centerY.equalTo(changeLanguageLabel)
        }
        
        changeLanguageView.snp.makeConstraints { make in
            make.top.equalTo(changeLanguageButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(1)
            
        }
        
        //MARK: change theme
        themeStyleLabel.text = "Қараңғы режим"
        themeStyleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        themeStyleLabel.textColor = UIColor(named: "1C2431")
        themeStyleLabel.textAlignment = .left
        
        themeStyleSwitch.onTintColor = UIColor(named: "B376F7")
        themeStyleSwitch.addTarget(self, action: #selector(changeTheme(_:)), for: .valueChanged)
        
        view.addSubview(themeStyleLabel)
        view.addSubview(themeStyleSwitch)
        
        themeStyleLabel.snp.makeConstraints { make in
            make.top.equalTo(changeLanguageView).offset(20)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalTo(themeStyleSwitch)
        }
        
        themeStyleSwitch.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(52)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(themeStyleLabel)
        }
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        checkThemeSwitcher()
        updateTheme()
    }
    
    
    
    private func setupUI() {
        view.addSubview(logoutButton)
        view.addSubview(titleLabel)
        view.addSubview(topView)
        view.addSubview(profileImageView)
        view.addSubview(myProfileTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(settingsView)
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(311)
            make.trailing.equalToSuperview().offset(-24)
            make.height.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.centerX.equalToSuperview()
        }
        
        topView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(0)
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.height.equalTo(1)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        myProfileTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(myProfileTitleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        settingsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(emailLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    @objc private func profileInfoTapped() {
        let VC = ProfileInfoViewController()
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func changeTheme(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "isDarkThemeEnabled")
            updateTheme()
        } else {
            UserDefaults.standard.set(false, forKey: "isDarkThemeEnabled")
            updateTheme()
        }
    }
    
    @objc private func changePasswordButtonTapped() {
        let VC = ChangePasswordViewController()
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    private func updateTheme() {
        if themeStyleSwitch.isOn {
            
            view.backgroundColor = UIColor(named: "111827")
            titleLabel.textColor = .white
            topView.backgroundColor = UIColor(named: "1C2431")
            myProfileTitleLabel.textColor = .white
            settingsView.backgroundColor = UIColor(named: "111827")
            
            profileInfoButton.setTitleColor(.white, for: .normal)
            profileInfoView.backgroundColor = UIColor(named: "1C2431")
            
            themeStyleLabel.textColor = .white
            
            changePasswordButton.setTitleColor(.white, for: .normal)
            changePasswordView.backgroundColor = UIColor(named: "1C2431")
            
            changeLanguageButton.setTitleColor(.white, for: .normal)
            changeLanguageView.backgroundColor = UIColor(named: "1C2431")
        } else {
            
            view.backgroundColor = .white
            titleLabel.textColor = UIColor(named: "111827")
            topView.backgroundColor = UIColor(named: "D1D5DB")
            myProfileTitleLabel.textColor = UIColor(named: "111827")
            settingsView.backgroundColor = UIColor(named: "F9FAFB")
            
            profileInfoButton.setTitleColor(UIColor(named: "111827"), for: .normal)
            profileInfoView.backgroundColor = UIColor(named: "D1D5DB")
            
            themeStyleLabel.textColor = UIColor(named: "111827")
            
            changePasswordButton.setTitleColor(UIColor(named: "111827"), for: .normal)
            changePasswordView.backgroundColor = UIColor(named: "D1D5DB")
            
            changeLanguageButton.setTitleColor(UIColor(named: "111827"), for: .normal)
            changeLanguageView.backgroundColor = UIColor(named: "D1D5DB")
        }
    }
    
    private func checkThemeSwitcher() {
        if let isDarkMode = UserDefaults.standard.value(forKey: "isDarkThemeEnabled") as? Bool, isDarkMode {
            themeStyleSwitch.isOn = true
        } else {
            themeStyleSwitch.isEnabled = true
        }
        
        
    }
}
