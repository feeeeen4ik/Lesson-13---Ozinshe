//
//  LanguageTableViewCell.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 22.11.2025.
//

import UIKit
import SnapKit

class LanguageTableViewCell: UITableViewCell {

    lazy var languageLabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827")
        
        return label
        
    }()
    
    lazy var chooseImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "Check")
        image.contentMode = .scaleAspectFit
        
        return image
        
    }()
    
    lazy var deviderView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "SheetDeviderColor")
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //убираем стандартный разделитель между ячейками
        separatorInset = UIEdgeInsets(
            top: 0,
            left: .greatestFiniteMagnitude,
            bottom: 0,
            right: 0
        )
        
        //устанавливаем фон при нажатии на ячейку (эффект активации клика)
        let selectedBG = UIView()
        selectedBG.backgroundColor = UIColor.systemGray5.withAlphaComponent(1)
        selectedBackgroundView = selectedBG
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(languageLabel)
        contentView.addSubview(chooseImage)
        contentView.addSubview(deviderView)
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(chooseImage)
        }
        
        chooseImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(24)
            make.top.equalToSuperview().offset(16)
        }
        
        deviderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
    }

}
