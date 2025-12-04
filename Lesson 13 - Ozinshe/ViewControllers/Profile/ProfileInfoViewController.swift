//
//  ProfileInfoViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 18.11.2025.
//

import UIKit
import SnapKit

class ProfileInfoViewController: UIViewController {
    
    lazy var upperView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "FFFFFF")
        
        return view
    }()
    
    lazy var nameLabel = {
        let label = UILabel()
        
        label.text = "Сіздің атыңыз"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var nameTextField = {
        let textField = UITextField()
        
        textField.text = "Феликс"
        textField.placeholder = "name"
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
        textField.placeholder = "email"
        textField.borderStyle = .none
        textField.keyboardType = .emailAddress
        textField.textAlignment = .left
        textField.textContentType = .emailAddress
        textField.textColor = UIColor(named: "111827")
        
        return textField
    }()
    
    lazy var emailBottomView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    lazy var phoneNumberLabel = {
        let label = UILabel()
        
        label.text = "Телефон"
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
        
        label.text = "Туылған күні"
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        title = "Жеке деректер"
        
        setupUI()
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
    }


}
