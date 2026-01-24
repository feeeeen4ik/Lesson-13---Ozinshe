//
//  BaseViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 08.12.2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(updateLanguage),
                name: .languageChanged,
                object: nil
            )
        
    }
    
    @objc func updateLanguage() {}

}
