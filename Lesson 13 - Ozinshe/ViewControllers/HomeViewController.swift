//
//  HomeViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 10.11.2025.
//

import UIKit
import SnapKit
import SVProgressHUD


nonisolated enum CollectionViewSections: CaseIterable {
    case popular
    case continueWatching
    case genres
}

nonisolated enum Collectionitems: Hashable {
    case popular(MoviesWrapper)
    case continueWatching(Movie)
    case genres(Genre)
}

final class HomeViewController: BaseViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSections, Collectionitems>!
    private var mainCollectionView: UICollectionView!
    
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
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [ weak self ] sectionIndex, environment -> NSCollectionLayoutSection?  in
            
            guard let self else { return nil }
            
            let sectionType = CollectionViewSections.allCases[sectionIndex]
            
            switch sectionType {
            case .popular:
                return createPopularSection()
            case .continueWatching:
                return createContinueWatchingSection()
            case .genres:
                return createGenresSection()
            }
        }
    }
    
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
    
    private func registerCellsForCollectionView() {
        let layout = createLayout()
        
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollectionView.backgroundColor = .clear
        
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
        
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CollectionViewSections, Collectionitems>(
            collectionView: mainCollectionView
        ) { collectionView, indexPath, item -> UICollectionViewCell? in
            
            
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
            }
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? HomeSectionHeaderView else { return nil }
            
            let section = CollectionViewSections.allCases[indexPath.section]
            
            switch section {
            case .popular:
                header.configure(title: "Танымал")
            case .continueWatching:
                header.configure(title: "Көруді жалғастырыңыз")
            case .genres:
                header.configure(title: "Жанрды таңдаңыз")
            }
            
            return header
        }
    }
    
    private func setupInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSections, Collectionitems>()
        snapshot.appendSections(CollectionViewSections.allCases)
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
}
