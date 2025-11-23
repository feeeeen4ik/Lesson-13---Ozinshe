//
//  ThemeManager.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 21.11.2025.
//

import UIKit

enum AppTheme: String {
    case light
    case dark
}

final class ThemeManager {
    
    private let themeKey = "isDarkThemeEnabled"
    
    static let shared = ThemeManager()
    
    var currentTheme: AppTheme {
        if let saved = UserDefaults.standard.string(forKey: themeKey),
           let theme = AppTheme(rawValue: saved) {
            return theme
        }
        return .light
    }
    
    func applyTheme(_ theme: AppTheme) {
        UserDefaults.standard.set(theme.rawValue, forKey: themeKey)
        
        let style: UIUserInterfaceStyle = (theme == .light) ? .light : .dark
        
        UIApplication.shared.connectedScenes.forEach { scene in
            guard let windowScene = scene as? UIWindowScene else { return }
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = style
            }
        }
        
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first {
            UIView.transition(with: window,
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
}
