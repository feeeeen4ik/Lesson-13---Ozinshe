//
//  MoviesByCategoryViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 21.01.2026.
//

import UIKit
import SnapKit
import SVProgressHUD

final class MoviesByCategoryViewController: UITableViewController {

    var movieCategory: Categorie?
    
    private var movies: [Movie] = []
    private let networkmanager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMoviesBy(category: movieCategory?.id ?? 0)
        registerCells()
        setupUI()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.identifier,
            for: indexPath
        ) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
    
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF")
        navigationItem.title = movieCategory?.name
        tableView.separatorStyle = .none
        
        
        //установка цвета для NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "FFFFFF")
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func registerCells() {
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    }
    
    private func loadMoviesBy(category: Int) {
        SVProgressHUD.show()
        
        networkmanager.getMoviesByCategory(categoryId: category) { [weak self] result in
            guard let self else { return }
            SVProgressHUD.dismiss()
            switch result {
            case .success(let success):
                movies = success
                tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}
