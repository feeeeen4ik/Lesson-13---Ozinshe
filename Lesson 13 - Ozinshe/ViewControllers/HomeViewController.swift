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
    //case continueWatching
}

final class HomeViewController: BaseViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSections, MoviesWrapper>!
    private var mainCollectionView: UICollectionView!
    private var MoviesMain: [MoviesWrapper] = []
    
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
        getMoviesMain()
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
                //            case .continueWatching:
                //                return createContinueWatchingSection()
            }
        }
    }
    
    private func createPopularSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        
        return section
    }
    
    private func createContinueWatchingSection() -> NSCollectionLayoutSection? {
        return nil
    }
    
    private func registerCellsForCollectionView() {
        let layout = createLayout()
        
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollectionView.backgroundColor = .clear
        
        mainCollectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: HomeCollectionCell.reuseIdentifier)
        
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CollectionViewSections, MoviesWrapper>(
            collectionView: mainCollectionView
        ) { collectionView, indexPath, movie -> UICollectionViewCell? in
            let sectionType = CollectionViewSections.allCases[indexPath.section]
            
            switch sectionType {
            case .popular:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeCollectionCell.reuseIdentifier,
                    for: indexPath
                ) as? HomeCollectionCell else { fatalError("Невозможно создать ячейку") }
                
                cell.configure(with: movie.movie)
                
                return cell
            }
        }
        
//        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSections, MoviesWrapper>()
//        snapshot.appendSections(CollectionViewSections.allCases)
//        snapshot.appendItems(MoviesMain, toSection: .popular)
//        dataSource.apply(snapshot)
    }
    
    private func getMoviesMain() {
        SVProgressHUD.show()
        
        networkManager.getMoviesMain { [ weak self ] result in
            guard let self else { return }
            
            SVProgressHUD.dismiss()
            
            switch result {
            case .success(let values):
                MoviesMain = values
                var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSections, MoviesWrapper>()
                    snapshot.appendSections([.popular])
                    snapshot.appendItems(MoviesMain, toSection: .popular)
                    dataSource.apply(snapshot, animatingDifferences: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
