//
//  FavoriteViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import SVProgressHUD
import Localize_Swift
import SnapKit

final class FavoritesTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        setupUI()
        loadFavorites()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.identifier,
            for: indexPath
        ) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
        
    private func loadFavorites() {
        SVProgressHUD.show()
        networkManager.getFavorites { [weak self] result in
            guard let self else { return }
            
            SVProgressHUD.dismiss()
            	
            switch result {
            case .success(let values):
                movies = values
                tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF")
        navigationItem.title = "favoritesMainTitle".localized()
        tableView.separatorStyle = .none
        
        //установка цвета для NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "FFFFFF")
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func registerCells() {
        tableView
            .register(
                FavoriteTableViewCell.self,
                forCellReuseIdentifier: FavoriteTableViewCell.identifier
            )
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let movie = movies[indexPath.row]
            
            networkManager.deleteFavoriteBy(id: movie.id) { [weak self] error in
                
                guard let self else { return }
                
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
    }
}
