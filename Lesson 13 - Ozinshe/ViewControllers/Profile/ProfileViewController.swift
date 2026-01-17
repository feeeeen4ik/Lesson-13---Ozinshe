//
//  ProfileViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import SnapKit
import Localize_Swift

final class ProfileViewController: BaseViewController, ProfileInfoViewControllerDelegate {

    var profileData: AccountData?
    
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
        
        label.text = "profileTitleLable".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var emailLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    //MARK: profile view
    let themeStyleSwitch = UISwitch()
    let profileInfoButton = UIButton()
    let profileTextLabel = UILabel()
    let changePasswordButton = UIButton()
    let changeLanguageButton = UIButton()
    let themeStyleLabel = UILabel()
    let profileInfoView = UIView()
    let changePasswordView = UIView()
    let changeLanguageView = UIView()
    let changeLanguageLabel = UILabel()
    
    lazy var settingsView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "F9FAFB")
        
        //MARK: profile info
        profileInfoButton.setTitle("profileInfoButton".localized(), for: .normal)
        profileInfoButton.setTitleColor(UIColor(named: "1C2431"), for: .normal)
        profileInfoButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        profileInfoButton.contentHorizontalAlignment = .left
        profileInfoButton.addTarget(self, action: #selector(profileInfoTapped), for: .touchUpInside)
        
        profileTextLabel.text = "profileInfoLabel".localized()
        profileTextLabel.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        profileTextLabel.textColor = UIColor(named: "9CA3AF")
        profileTextLabel.setContentHuggingPriority(.required, for: .horizontal)
        profileTextLabel
            .setContentCompressionResistancePriority(
                .required,
                for: .horizontal
            )
        
        let profileButtonSymbolImage = UIImageView()
        profileButtonSymbolImage.image = UIImage(named: "ChevronRight")
        
        profileInfoView.backgroundColor = UIColor(named: "D1D5DB")
        
        view.addSubview(profileInfoButton)
        view.addSubview(profileTextLabel)
        view.addSubview(profileButtonSymbolImage)
        view.addSubview(profileInfoView)
        
        profileInfoButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalTo(profileTextLabel.snp.leading)
        }
        
        profileTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileInfoButton.snp.trailing).offset(145)
            make.centerY.equalTo(profileInfoButton)
        }
        
        profileButtonSymbolImage.snp.makeConstraints { make in
            make.leading.equalTo(profileTextLabel.snp.trailing).offset(8)
            make.height.width.equalTo(16)
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(profileTextLabel)
        }
        
        profileInfoView.snp.makeConstraints { make in
            make.top.equalTo(profileInfoButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(1)
            
        }
        
        //MARK: change password
        changePasswordButton.setTitle("changePasswordButton".localized(), for: .normal)
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
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(profileInfoView).offset(20)
            make.trailing.equalTo(changePasswordSymbolImage.snp.leading)
        }
        
        changePasswordSymbolImage.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(changePasswordButton)
        }
        
        changePasswordView.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(1)
            
        }
        
        //MARK: change language
        changeLanguageButton
            .setTitle("changeLanguageButton".localized(), for: .normal)
        changeLanguageButton.setTitleColor(UIColor(named: "1C2431"), for: .normal)
        changeLanguageButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        changeLanguageButton.contentHorizontalAlignment = .left
        changeLanguageButton
            .addTarget(
                self,
                action: #selector(changeLanguageButtonTapped),
                for: .touchUpInside
            )
        
        changeLanguageLabel.text = LanguageModel.getChoosenSystemLanguage().title
        changeLanguageLabel.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        changeLanguageLabel.textColor = UIColor(named: "9CA3AF")
        changeLanguageLabel
            .setContentHuggingPriority(.required, for: .horizontal)
        changeLanguageLabel
            .setContentCompressionResistancePriority(
                .required,
                for: .horizontal
            )
        
        let changeLanguageSymbolImage = UIImageView()
        changeLanguageSymbolImage.image = UIImage(named: "ChevronRight")
        
        changeLanguageView.backgroundColor = UIColor(named: "D1D5DB")
        
        view.addSubview(changeLanguageButton)
        view.addSubview(changeLanguageLabel)
        view.addSubview(changeLanguageSymbolImage)
        view.addSubview(changeLanguageView)
        
        changeLanguageButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(changePasswordView.snp.bottom).offset(20)
            make.trailing.equalTo(changeLanguageLabel.snp.leading)
        }
        
        changeLanguageLabel.snp.makeConstraints { make in
            make.leading.equalTo(changeLanguageButton.snp.trailing).offset(145)
            make.centerY.equalTo(changeLanguageButton)
        }
        
        changeLanguageSymbolImage.snp.makeConstraints { make in
            make.leading.equalTo(changeLanguageLabel.snp.trailing).offset(8)
            make.height.width.equalTo(16)
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(changeLanguageLabel)
        }
        
        changeLanguageView.snp.makeConstraints { make in
            make.top.equalTo(changeLanguageButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(1)
            
        }
        
        //MARK: change theme
        themeStyleLabel.text = "themeStyleLabel".localized()
        themeStyleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        themeStyleLabel.textColor = UIColor(named: "1C2431")
        themeStyleLabel.textAlignment = .left
        
        themeStyleSwitch.onTintColor = UIColor(named: "B376F7")
        themeStyleSwitch.addTarget(self, action: #selector(changeTheme(_:)), for: .valueChanged)
        themeStyleSwitch.isOn = ThemeManager.shared.currentTheme == .dark
        
        view.addSubview(themeStyleLabel)
        view.addSubview(themeStyleSwitch)
        
        themeStyleLabel.snp.makeConstraints { make in
            make.top.equalTo(changeLanguageView).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(themeStyleSwitch)
        }
        
        themeStyleSwitch.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(52)
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalTo(themeStyleLabel)
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileData()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(named: "ProfileVC")
        navigationItem.title = "profileMainTitleLable".localized()
        
        //установка цвета для NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "FFFFFF")
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "LogOut")?.withRenderingMode(
                .alwaysOriginal
            ),
            style: .plain,
            target: self,
            action: #selector(logOut)
        )
        
        view.addSubview(topView)
        view.addSubview(profileImageView)
        view.addSubview(myProfileTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(settingsView)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().offset(0)
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
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(emailLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    @objc private func profileInfoTapped() {
        let VC = ProfileInfoViewController()
        VC.hidesBottomBarWhenPushed = true
        VC.delegate = self
        VC.profileData = profileData
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func changeTheme(_ sender: UISwitch) {
        let newTheme: AppTheme = sender.isOn ? .dark : .light
        
        ThemeManager.shared.applyTheme(newTheme)
    }
    
    @objc private func changePasswordButtonTapped() {
        let VC = ChangePasswordViewController()
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func logOut() {
        let VC = LogOutViewController()
        
        let navVC = UINavigationController(rootViewController: VC)
        
        //настройка navigationBar и sheetPresentationCOntroller
        navVC.modalPresentationStyle = .pageSheet
        navVC.navigationBar.prefersLargeTitles = true
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navVC, animated: true)
    }
    
    @objc private func changeLanguageButtonTapped() {
        let VC = LanguagesTableViewController()
        VC.delegate = self
        
        let navVC = UINavigationController(rootViewController: VC)
        //настройка navigationBar и sheetPresentationCOntroller
        navVC.modalPresentationStyle = .pageSheet
        navVC.navigationBar.prefersLargeTitles = true
        
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navVC, animated: true)
    }
    
    private func getProfileData() {
        networkManager.getProfileData { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                profileData = response
                emailLabel.text = profileData?.user.email ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func updateLanguage() {
        navigationItem.title = "profileMainTitleLable".localized()
        myProfileTitleLabel.text = "profileTitleLable".localized()
        profileInfoButton.setTitle("profileInfoButton".localized(), for: .normal)
        profileTextLabel.text = "profileInfoLabel".localized()
        changePasswordButton.setTitle("changePasswordButton".localized(), for: .normal)
        changeLanguageButton
            .setTitle("changeLanguageButton".localized(), for: .normal)
        themeStyleLabel.text = "themeStyleLabel".localized()
    }
    
    func didUpdateProfileData(needToReloadData : Bool) {
        if needToReloadData {
            getProfileData()
        }
    }
}

extension ProfileViewController: LanguageSelectedProtocol {
    func didSelectLanguage(_ language: AppLanguages) {
        changeLanguageLabel.text = language.title
    }
}
