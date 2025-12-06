//
//  Languages.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 23.11.2025.
//

import UIKit
import Localize_Swift

enum AppLanguages: String, CaseIterable, Codable {
    case en = "en"
    case ru = "ru"
    case kz = "kk"
    
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
    
    static func getAllLanguages() -> [LanguageModel] {
        AppLanguages.allCases.map {
            LanguageModel(id: $0)
        }
    }
    
    static func setSystemLanguage(_ language: AppLanguages) {
        Localize.setCurrentLanguage(language.rawValue)
    }
    
    static func getChoosenSystemLanguage() -> AppLanguages {
        AppLanguages(rawValue: Localize.currentLanguage()) ?? .en
    }
}


