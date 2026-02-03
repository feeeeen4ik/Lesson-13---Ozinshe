//
//  SearchViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import Localize_Swift
import SVProgressHUD
import SnapKit

final class SearchViewController: BaseViewController {
    
    var categories: [Categorie] = []
    var searchedMovies: [Movie] = []
    
    lazy var searchTextField = {
        let textField = CustomTextField()
        
        textField.placeholder = "searchMainTitel".localized()
        textField.textAlignment = .left
        textField.textColor = UIColor(named: "111827")
        textField.layer.cornerRadius = 12
        textField.keyboardType = .default
        textField.backgroundColor = UIColor(named: "TextFields")
        textField.padding = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        textField.delegate = self
        
        return textField
    }()
    
    lazy var searchButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "SearchButton"), for: .normal)
        button.setImage(UIImage(named: "SearchButtonTapped"), for: .highlighted)
        button
            .addTarget(
                self,
                action: #selector(searchMovies),
                for: .touchUpInside
            )
        
        return button
    }()
    
    lazy var searchStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(searchTextField)
        stackView.addArrangedSubview(searchButton)
        
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        return stackView
    }()
    
    lazy var searchedMoviesTableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    lazy var categoryLabel = {
        let label = UILabel()
        
        label.text = "categoryLabel".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var categoryColletionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = false
        
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHideGesture()
        setupUI()
        getCategories()
    }
    
    private func setupUI() {
        
        registerMovieTableCells()
        registerCategoryTableCells()
        
        navigationItem.title = "searchMainTitel".localized()
        view.backgroundColor = UIColor(named: "FFFFFF")
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "FFFFFF")
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.addSubviews(
                searchStackView,
                categoryLabel,
                categoryColletionView,
                searchedMoviesTableView
            )
        
        searchStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(searchStackView.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(24)
        }
        
        categoryColletionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchedMoviesTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
    
    private func setupKeyboardHideGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func registerMovieTableCells() {
        searchedMoviesTableView
            .register(
                FavoriteTableViewCell.self,
                forCellReuseIdentifier: FavoriteTableViewCell
                    .identifier)
    }
    
    private func registerCategoryTableCells() {
        categoryColletionView
            .register(
                CategoryCell.self,
                forCellWithReuseIdentifier: CategoryCell.reuseId
            )
    }
    
    private func showCategories() {
        categoryColletionView.isHidden = false
        searchedMoviesTableView.isHidden = true
        categoryLabel.text = "categoryLabel".localized()
    }
    
    private func showSearchedMovies() {
        categoryColletionView.isHidden = true
        searchedMoviesTableView.isHidden = false
        categoryLabel.text = "searchResult".localized()
    }
    
    @objc private func searchMovies() {
        guard let query = searchTextField.text, !query.isEmpty else { return }
        
        SVProgressHUD.show()
        networkManager.getMoviesBySearch(query: query) { [weak self] result in
            guard let self else { return }
            
            SVProgressHUD.dismiss()
            switch result {
            case .success(let data):
                searchedMovies = data
                searchedMoviesTableView.reloadData()
                showSearchedMovies()
            case .failure(let error):
                print(error.localizedDescription)
                showCategories()
            }
            
        }
    }
    
    private func getCategories() {
        SVProgressHUD.show()
        networkManager.getAllCategories { [weak self] result in
            guard let self else { return }
            
            SVProgressHUD.dismiss()
            switch result {
            case .success(let data):
                categories = data
                categoryColletionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if searchTextField.text?.isEmpty == true {
            showCategories()
        }
    }
    
    override func updateLanguage() {
        navigationItem.title = "searchMainTitel".localized()
        categoryLabel.text = "categoryLabel".localized()
        searchTextField.placeholder = "searchMainTitel".localized()
    }
}





extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        cell.categoryNamelabel.text = categories[indexPath.row].name
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        
        let VC = MoviesByCategoryViewController()
        VC.movieCategory = category
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
}


extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.identifier,
            for: indexPath
        ) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = searchedMovies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
}

extension SearchViewController: UITableViewDelegate {
    
}
