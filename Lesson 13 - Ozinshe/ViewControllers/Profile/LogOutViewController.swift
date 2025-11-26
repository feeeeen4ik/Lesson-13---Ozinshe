//
//  LogOutViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 25.11.2025.
//

import UIKit
import SnapKit

class LogOutViewController: UIViewController {
    
    lazy var container = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var topLabel = {
        let label = UILabel()
        
        label.text = "Сіз шынымен аккаунтыныздан"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        
        return label
    }()
    
    lazy var confirmButton = {
        let button = UIButton()
        
        //настройка эффекта нажатия
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "7E2DFC")
        config.cornerStyle = .large

        button.configuration = config
        button.configurationUpdateHandler = { btn in
            switch btn.state {
            case .highlighted:
                btn.alpha = 0.6
            default:
                btn.alpha = 1.0
            }
        }
        
        button.setTitle("Иә, шығу", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        
        return button
    }()
    
    lazy var denyButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.cornerStyle = .large
        
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
        button.setTitle("Жоқ", for: .normal)
        button.tintColor = UIColor(named: "5415C6")
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
