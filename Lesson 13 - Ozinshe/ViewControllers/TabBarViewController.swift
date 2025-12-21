//
//  ViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }
    
    private func setupTabs() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoritesVC = FavoritesTableViewController()
        let profileVC = ProfileViewController()
        let profileNC = UINavigationController(rootViewController: profileVC)
        
        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Home"),
            selectedImage: UIImage(named: "HomePressed")
        )
        
        searchVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Search"),
            selectedImage: UIImage(named: "SearchPressed")
        )
        
        profileNC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Profile"),
            selectedImage: UIImage(named: "ProfilePressed")
        )
        
        favoritesVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Favorite"),
            selectedImage: UIImage(named: "FavoritePressed")
        )
        
        
        setViewControllers(
            [homeVC, searchVC, favoritesVC, profileNC],
            animated: true
        )
    }


}

