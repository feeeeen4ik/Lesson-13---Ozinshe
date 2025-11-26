//
//  LanguagesTableViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 22.11.2025.
//

import UIKit

// протокол установки labelLanguage на главном VC профиля
protocol LanguageSelectedProtocol: AnyObject {
    func didSelectLanguage(_ language: AppLanguages)
}

class LanguagesTableViewController: UITableViewController {
    
    weak var delegate: LanguageSelectedProtocol?
    
    let languages = LanguageModel.getAllLanguages()
    let choosenSystemLanguage = LanguageModel.getChoosenSystemLanguage()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let sheet = sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return self.tableView.contentSize.height + 155
                }
            ]
            sheet.prefersGrabberVisible = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //регистрация ячейки с ID
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageTableViewCell
        
        cell.selectionStyle = .default
        cell.languageLabel.text = languages[indexPath.row].id.title
        cell.chooseImage.isHidden = languages[indexPath.row].id != choosenSystemLanguage ? true : false
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = languages[indexPath.row].id
        LanguageModel.saveSystemLanguage(selectedLanguage)
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.didSelectLanguage(selectedLanguage)
        
        dismiss(animated: true)
    }

}
