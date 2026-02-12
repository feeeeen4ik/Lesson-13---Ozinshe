//
//  HomeViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import SnapKit
import SVProgressHUD


nonisolated enum CollectionViewSections: Hashable {
    case popular
    case continueWatching
    case genres
    case ages
    case mainCategoryItem(Int)
}

nonisolated enum Collectionitems: Hashable {
    case popular(MoviesWrapper)
    case continueWatching(Movie)
    case genres(Genre)
    case ages(Age)
    case mainCategoryItem(Movie)
}

final class HomeViewController: BaseViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSections, Collectionitems>!
    private var mainCollectionView: UICollectionView!
    private var activeSections: [CollectionViewSections] = [.popular, .continueWatching, .genres, .ages]
    private var mainCategoryItems: [MainMoviesByCategories] = []
    
    lazy var containerForLogo = {
        let view = UIView()
        
        return view
    }()
    
    lazy var homeLogo = {
        let image = UIImageView()
        image.image = UIImage(named: "HomeLogo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = false
        
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCellsForCollectionView()
        setupUI()
        configureDataSource()
        setupInitialSnapshot()
        
        getMoviesMain()
        getContinueWatchMovies()
        getGenres()
        getAges()
        getMainMoviesByCategory()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF")
        
        containerForLogo.addSubview(homeLogo)
        
        homeLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(4)
        }
        
        containerForLogo.snp.makeConstraints { make in
            make.width.equalTo(navigationController?.navigationBar.frame.width ?? 0)
        }
        
        navigationItem.titleView = containerForLogo
        navigationItem.titleView?.contentMode = .left
        
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: Create CollectionView
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [ weak self ] sectionIndex, environment -> NSCollectionLayoutSection?  in
            
            guard let self else { return nil }
            
            let sectionType = activeSections[sectionIndex]
            
            switch sectionType {
            case .popular:
                return createPopularSection()
            case .continueWatching:
                return createContinueWatchingSection()
            case .genres:
                return createGenresSection()
            case .ages:
                return createAgesSection()
            case .mainCategoryItem(_):
                return createMoviesByCategorySection()
            }
        }
    }
    
    private func registerCellsForCollectionView() {
        let layout = createLayout()
        
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollectionView.backgroundColor = .clear
        mainCollectionView.delegate = self
        
        mainCollectionView
            .register(
                HomeSectionHeaderView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier
            )
        
        mainCollectionView.register(HomePopularCollectionCell.self, forCellWithReuseIdentifier: HomePopularCollectionCell.reuseIdentifier)
        
        mainCollectionView.register(HomeContinueWatchCollectionCell.self,
                forCellWithReuseIdentifier: HomeContinueWatchCollectionCell.reuseIdentifier)
        
        mainCollectionView
            .register(HomeGenresCollectionCell.self,
                forCellWithReuseIdentifier: HomeGenresCollectionCell.reuseIdentifier)
        
        mainCollectionView
            .register(HomeAgesCollectionCell.self,
                      forCellWithReuseIdentifier: HomeAgesCollectionCell.reuseIdentifier)
        mainCollectionView
            .register(
                HomeMoviesByCategoryCollectionCell.self,
                forCellWithReuseIdentifier: HomeMoviesByCategoryCollectionCell.reuseIdentifier)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CollectionViewSections, Collectionitems>(
            collectionView: mainCollectionView
        ) {
            collectionView,
            indexPath,
            item -> UICollectionViewCell? in
            
            
            switch item {
            case .popular(let movieWrapper):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomePopularCollectionCell.reuseIdentifier,
                    for: indexPath
                ) as? HomePopularCollectionCell else { fatalError("Невозможно создать ячейку") }
                
                cell.configure(with: movieWrapper.movie)
                
                return cell
                
            case .continueWatching(let ContinueWatchMovie):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeContinueWatchCollectionCell.reuseIdentifier,
                    for: indexPath
                ) as? HomeContinueWatchCollectionCell else {
                    fatalError("Невозможно создать ячейку")
                }
                
                cell.configure(with: ContinueWatchMovie)
                
                return cell
            case .genres(let genres):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGenresCollectionCell.reuseIdentifier, for: indexPath) as? HomeGenresCollectionCell else { fatalError("Невозможно создать ячейку")
                }
                
                cell.configure(with: genres)
                
                return cell
            case .ages(let ages):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeAgesCollectionCell.reuseIdentifier, for: indexPath) as? HomeAgesCollectionCell else { fatalError("Невозможно создать ячейку")
                }
                
                cell.configure(with: ages)
                
                return cell
            case .mainCategoryItem(let categoryMovieItem):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeMoviesByCategoryCollectionCell.reuseIdentifier,
                    for: indexPath
                ) as? HomeMoviesByCategoryCollectionCell else {
                    fatalError("Невозможно создать ячейку")
                }
                
                cell.configure(with: categoryMovieItem)
                
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { [ weak self ] (collectionView, kind, indexPath) in
            guard let self else { return nil }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeSectionHeaderView else { return nil }
            
            let section = activeSections[indexPath.section]
            
            switch section {
            case .popular:
                header.configure(title: "Танымал")
            case .continueWatching:
                header.configure(title: "Көруді жалғастырыңыз")
            case .genres:
                header.configure(title: "Жанрды таңдаңыз")
            case .ages:
                header.configure(title: "Жасына сәйкес")
            case .mainCategoryItem(let id):
                let name = mainCategoryItems.first(where: {$0.categoryId == id})?.categoryName ?? ""
                header.configure(title: name)
            }
            
            return header
        }
    }
    
    private func setupInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSections, Collectionitems>()
        snapshot.appendSections(activeSections)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(for section: CollectionViewSections, items: [Collectionitems]) {
        var snapshot = dataSource.snapshot()
        
        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
   //MARK: Create sections
    private func createPopularSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(340),
            heightDimension: .absolute(240)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 20,
            bottom: 32,
            trailing: 0
        )
        
        return section
    }
    
    private func createContinueWatchingSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(184),
            heightDimension: .absolute(156)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 20,
            bottom: 32,
            trailing: 0
        )
        
        
        return section
    }
    
    private func createGenresSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(184),
            heightDimension: .absolute(112)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 32, trailing: 0)
        
        
        return section
    }
    
    private func createAgesSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(184),
            heightDimension: .absolute(112)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 32, trailing: 0)
        
        
        return section
    }
    
    private func createMoviesByCategorySection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(112),
            heightDimension: .absolute(208)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 20,
            bottom: 32,
            trailing: 0
        )
        
        
        return section
    }
    
    //MARK: Networking
    private func getMoviesMain() {
        
        networkManager.getMoviesMain { [ weak self ] result in
            guard let self else { return }
            
            switch result {
            case .success(let values):
                let items = values.map { Collectionitems.popular($0) }
                applySnapshot(for: .popular, items: items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getContinueWatchMovies() {
        
        networkManager
            .getUserWatchHistory{ [ weak self ] result in
            guard let self else { return }
            
            switch result {
            case .success(let values):
                let items = values.map { Collectionitems.continueWatching($0) }
                applySnapshot(for: .continueWatching, items: items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getGenres() {
        networkManager.getAllGenres { [ weak self ] result in
            guard let self else { return }
            
            switch result {
            case .success(let value):
                let items = value.map { Collectionitems.genres($0) }
                applySnapshot(for: .genres, items: items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAges() {
        networkManager.getCategoryAges { [ weak self ] result in
            guard let self else { return }
            
            switch result {
            case .success(let value):
                let items = value.map { Collectionitems.ages($0) }
                applySnapshot(for: .ages, items: items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getMainMoviesByCategory() {
        networkManager.getMainMoviesByCategory { [ weak self ] result in
            guard let self else { return }
            
            switch result {
            case .success(let categoriesMovie):
                mainCategoryItems = categoriesMovie
                var snapshot = dataSource.snapshot()
                
                if categoriesMovie.count > 0 {
                    let section = CollectionViewSections.mainCategoryItem(categoriesMovie[0].categoryId)
                    if let index = activeSections.firstIndex(of: .continueWatching) {
                        activeSections.insert(section, at: index + 1)
                    }
                    snapshot.insertSections([section], afterSection: .continueWatching)
                    let items = categoriesMovie[0].movies.map{ Collectionitems.mainCategoryItem($0) }
                    snapshot.appendItems(items, toSection: section)
                }
                
                if categoriesMovie.count > 1 {
                    let section = CollectionViewSections.mainCategoryItem(categoriesMovie[1].categoryId)
                    if let index = activeSections.firstIndex(of: .genres) {
                        activeSections.insert(section, at: index + 1)
                    }
                    snapshot.insertSections([section], afterSection: .genres)
                    let items = categoriesMovie[1].movies.map{ Collectionitems.mainCategoryItem($0) }
                    snapshot.appendItems(items, toSection: section)
                }
                
                if categoriesMovie.count > 2 {
                    let section = CollectionViewSections.mainCategoryItem(categoriesMovie[2].categoryId)
                    if let index = activeSections.firstIndex(of: .ages) {
                        activeSections.insert(section, at: index + 1)
                    }
                    snapshot.insertSections([section], afterSection: .ages)
                    let items = categoriesMovie[2].movies.map{ Collectionitems.mainCategoryItem($0) }
                    snapshot.appendItems(items, toSection: section)
                }
                
                dataSource.apply(snapshot, animatingDifferences: false)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: Extensions
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch selectedItem {
        case .popular(let moviesWrapper):
            print(moviesWrapper.movie.name)
            
        case .continueWatching(let movie):
            print(movie.name)
            
        case .genres(let genre):
            print(genre.name)
            let VC = MoviesByCategoryViewController()
            VC.movieGenreId = genre.id
            VC.title = genre.name
            
            navigationController?.pushViewController(VC, animated: true)
            
        case .ages(let age):
            print(age.name)
            let VC = MoviesByCategoryViewController()
            VC.movieCategoryAgeId = age.id
            VC.title = age.name
            
            navigationController?.pushViewController(VC, animated: true)
            
        case .mainCategoryItem(let movie):
            print(movie.name)
        }
    }
}
