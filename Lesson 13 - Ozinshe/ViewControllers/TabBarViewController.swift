//
//  ViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let tabBarImages: [(normal: String, selected: String)] = [
        ("Home", "HomePressed"),
        ("Search", "SearchPressed"),
        ("Favorite", "FavoritePressed"),
        ("Profile", "ProfilePressed")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTabBarImages()
        setupTabs()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.updateTabBarImages()
        }
    }
    
    private func setupTabs() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let searchNC = UINavigationController(rootViewController: searchVC)
        let favoritesVC = FavoritesTableViewController()
        let favoritesNC = UINavigationController(rootViewController: favoritesVC)
        let profileVC = ProfileViewController()
        let profileNC = UINavigationController(rootViewController: profileVC)
        
        setViewControllers(
            [homeVC, searchNC, favoritesNC, profileNC],
            animated: true
        )
    }
    
    private func updateTabBarImages() {
        guard let tabBarItems = tabBar.items else { return }
        
        for (index, images) in tabBarImages.enumerated() {
            guard index < tabBarItems.count else { continue }
            
            tabBarItems[index].image = UIImage(
                named: images.normal,
                in: Bundle.main,
                compatibleWith: traitCollection
            )?.withRenderingMode(.alwaysOriginal)
            
            tabBarItems[index].selectedImage = UIImage(
                named: images.selected,
                in: Bundle.main,
                compatibleWith: traitCollection
            )?.withRenderingMode(.alwaysOriginal)
        }
    }
    
}

