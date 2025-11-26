//
//  Languages.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 23.11.2025.
//

import UIKit

enum AppLanguages: String, CaseIterable, Codable {
    case en
    case ru
    case kz
    
    var title: String {
        switch self {
        case .en: return "English"
        case .ru: return "Русский"
        case .kz: return "Қазақша"
        }
    }
}

struct LanguageModel {
    let id: AppLanguages
    let isSelected: Bool
    
    static func getAllLanguages(selected: AppLanguages? = nil) -> [LanguageModel] {
        AppLanguages.allCases.map {
            LanguageModel(id: $0, isSelected: $0 == selected)
        }
    }
    
    static func saveSystemLanguage(_ language: AppLanguages) {
        if let data = try? JSONEncoder().encode(language) {
            UserDefaults.standard.set(data, forKey: "ChoosedLanguage")
        } else {
            print("Ошибка: не удалось закодировать язык")
        }
    }
    
    static func getChoosenSystemLanguage() -> AppLanguages {
        
        guard let data = UserDefaults.standard.data(forKey: "ChoosedLanguage"),
              let choosenLanguageFromData = try? JSONDecoder().decode(
                AppLanguages.self,
                from: data)
        else {
            return .kz
        }
        
        return choosenLanguageFromData
    }
}


