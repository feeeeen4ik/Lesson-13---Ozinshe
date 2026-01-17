//
//  SearchViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import Localize_Swift
import SVProgressHUD
import SnapKit

final class SearchViewController: BaseViewController {
    
    lazy var searchTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "searchMainTitlel".localized()
        textField.textAlignment = .left
        textField.textColor = UIColor(named: "111827")
        textField.layer.cornerRadius = 12
        textField.keyboardType = .default
        textField.backgroundColor = UIColor(named: "TextFields")
        textField.padding = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        textField.delegate = self
        
        return textField
    }()
    
    lazy var searchButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "SearchButton"), for: .normal)
        button.setImage(UIImage(named: "SearchButtonTapped"), for: .highlighted)
        
        return button
    }()
    
    lazy var searchStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(searchTextField)
        stackView.addArrangedSubview(searchButton)
        
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHideGesture()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "searchMainTitlel".localized()
        view.backgroundColor = UIColor(named: "FFFFFF")
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "FFFFFF")
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.addSubview(searchStackView)
        
        searchStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setupKeyboardHideGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
