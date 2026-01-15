//
//  ProfileInfoViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 18.11.2025.
//

import UIKit
import SnapKit
import Localize_Swift
import SVProgressHUD

protocol ProfileInfoViewControllerDelegate: AnyObject {
    func didUpdateProfileData(needToReloadData : Bool)
}

final class ProfileInfoViewController: BaseViewController {
    
    var buttonBottomConstraint: Constraint?
    let networkManager = NetworkManager.shared
    var profileData: AccountData?
    weak var delegate: ProfileInfoViewControllerDelegate?
    
    lazy var upperView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "FFFFFF")
        
        return view
    }()
    
    lazy var nameLabel = {
        let label = UILabel()
        
        label.text = "profileInfoNameLabel".localized()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var nameTextField = {
        let textField = UITextField()
        
        textField.text = "Феликс"
        textField.placeholder = "profileInfoNameTextFieldPlaceHolder"
            .localized()
        textField.borderStyle = .none
        textField.keyboardType = .default
        textField.textAlignment = .left
        textField.textColor = UIColor(named: "111827")
        
        return textField
    }()
    
    lazy var nameBottomView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    lazy var emailLabel = {
        let label = UILabel()
        
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var emailTextField = {
        let textField = UITextField()
        
        textField.text = "123321@mail.ru"
        textField.placeholder = "Email"
        textField.borderStyle = .none
        textField.keyboardType = .emailAddress
        textField.textAlignment = .left
        textField.textContentType = .emailAddress
        textField.textColor = UIColor(named: "111827")
        textField.isEnabled = false
        
        return textField
    }()
    
    lazy var emailBottomView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    lazy var phoneNumberLabel = {
        let label = UILabel()
        
        label.text = "profileInfoPhoneNumberLabel".localized()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var phoneNumberTextField = {
        let textField = UITextField()
        
        textField.text = "+7-707-777-77-77"
        textField.placeholder = "+7-(___)-___-__-__"
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.textAlignment = .left
        textField.textContentType = .telephoneNumber
        textField.textColor = UIColor(named: "111827")
        
        return textField
    }()
    
    lazy var phoneNumberBottomView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    lazy var birthdayLabel = {
        let label = UILabel()
        
        label.text = "profileInfoBirthdayLabel".localized()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var birthdayDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Calendar.current.date(from: DateComponents(year: 1900))
        datePicker.backgroundColor = .clear
        datePicker.tintColor = .label
        datePicker.subviews.first?.backgroundColor = .clear
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.tintColor = UIColor(named: "111827")
        
        let components = DateComponents(year: 1994, month: 12, day: 94)
        datePicker.date = Calendar.current.date(from: components) ?? Date()
        
        return datePicker
    }()
    
    lazy var birthdayBottomView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    lazy var applyProfileChangesButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 12
        button
            .setTitle(
                "changePaswordApplyPasswordButton".localized(),
                for: .normal
            )
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(applyProfileChanges), for: .touchUpInside)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        title = "profileInfoTitle".localized()
        
        setupKeyboardObservers()
        setupUI()
        setupUiData()
    }
    
    private func setupUI() {
        view.addSubview(upperView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(nameBottomView)
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(phoneNumberBottomView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailBottomView)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayDatePicker)
        view.addSubview(birthdayBottomView)
        view.addSubview(applyProfileChangesButton)
        
        upperView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.height.equalTo(1)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        nameBottomView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBottomView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        emailBottomView.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(emailBottomView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        phoneNumberBottomView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberBottomView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        birthdayDatePicker.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
        }
        
        birthdayBottomView.snp.makeConstraints { make in
            make.top.equalTo(birthdayDatePicker.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        applyProfileChangesButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            buttonBottomConstraint = make.bottom
                .equalTo(view.safeAreaLayoutGuide)
                .inset(16).constraint
            make.height.equalTo(56)
        }
    }
    
    @objc private func applyProfileChanges() {
        if nameTextField.text == "" {
            showAlert(title: "Ошибка!", message: "Поле 'Имя' не может быть пустым!")
            return
        }
        
        let userName = nameTextField.text!
        let phoneNumber = phoneNumberTextField.text!.filter { $0.isNumber }
        let date = birthdayDatePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthDate = formatter.string(from: date)
        
        SVProgressHUD.show()
        networkManager
            .changeProfileData(
                userName: userName,
                birthDate: birthDate,
                phoneNumber: phoneNumber) { [weak self] error in
                    guard let self else { return }
                    
                    SVProgressHUD.dismiss()
                    if let error {
                        print(error.localizedDescription)
                        return
                    } else {
                        delegate?.didUpdateProfileData(needToReloadData: true)
                        navigationController?.popViewController(animated: true)
                        showAlert(title: "Успех!", message: "Данные профиля обновлены!")
                    }
                }
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWiilShow(notification:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWiilHide(notification:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
    }
    
    @objc private func keyboardWiilShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        buttonBottomConstraint?.update(inset: keyboardFrame.height)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWiilHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        buttonBottomConstraint?.update(inset: 16)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func setupUiData() {
        nameTextField.text = profileData?.name ?? ""
        emailTextField.text = profileData?.user.email ?? ""
        phoneNumberTextField.text = formatPhoneNumber(from: profileData?.phoneNumber ?? "")
        birthdayDatePicker.date = formatBirthDate(from: profileData?.birthDate ?? "") ?? Date()
        
    }
    
    private func formatPhoneNumber(from digits: String) -> String {
        let maxDigits = 11
        let cleanDigits = String(digits.prefix(maxDigits))
        let chars = Array(cleanDigits)
        
        var result = ""
        for (index, char) in chars.enumerated() {
            switch index {
            case 0:
                if char == "8" {
                    result += String(char)
                } else {
                    result += "+\(char)"
                }
            case 1:
                result += "(\(char)"
            case 4:
                result += ")\(char)"
            case 7:
                result += "-\(char)"
            case 9:
                result += "-\(char)"
            default:
                result += String(char)
            }
        }
        return result
    }
    
    private func formatBirthDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    override func updateLanguage() {
        title = "profileInfoTitle".localized()
        nameLabel.text = "profileInfoNameLabel".localized()
        nameTextField.placeholder = "profileInfoNameTextFieldPlaceHolder"
            .localized()
        phoneNumberLabel.text = "profileInfoPhoneNumberLabel".localized()
        birthdayLabel.text = "profileInfoBirthdayLabel".localized()
    }

}
