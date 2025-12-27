//
//  FavoriteViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import SVProgressHUD

final class FavoritesTableViewController: UITableViewController {
    private let networkManager = NetworkManager.shared
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView
            .register(
                FavoriteTableViewCell.self,
                forCellReuseIdentifier: FavoriteTableViewCell.identifier
            )
        SVProgressHUD.show()
        networkManager.getFavorites { [unowned self] result in
            switch result {
            case .success(let values):
                SVProgressHUD.dismiss()
                movies = values
                tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error.localizedDescription)
                
            }
        }
        view.backgroundColor = UIColor(named: "FFFFFF")
        tableView.separatorStyle = .none
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.identifier,
            for: indexPath
        ) as! FavoriteTableViewCell
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
    
}
