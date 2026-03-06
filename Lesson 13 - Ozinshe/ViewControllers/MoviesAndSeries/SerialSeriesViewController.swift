//
//  SerialSeriesViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 25.02.2026.
//

import UIKit
import SnapKit


enum Sections: Int, CaseIterable {
    case seasons
    case series
}

nonisolated enum CollectionItems: Hashable {
    case season(Season)
    case series(Series)
}


final class SerialSeriesViewController: BaseViewController {
    
    var movieSeasonsAndSeries: [Season] = []
    
    private var dataSource: UICollectionViewDiffableDataSource<Sections, CollectionItems>!
    private var mainCollectionView: UICollectionView!
    private var selectedSeasonIndex: Int = 0
    
    lazy var upperLineView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "F9FAFB")
        updateSnapshot(with: movieSeasonsAndSeries.first?.videos ?? [])
        
        registerCellsForCollectionView()
        setupUI()
        configureDataSource()
    }
    
    private func setupUI() {
        view.addSubview(upperLineView)
        view.addSubview(mainCollectionView)
        
        upperLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(upperLineView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sections, CollectionItems>(collectionView: mainCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch item {
            case .season(let season):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SeasonCell.reuseIdentifier,
                    for: indexPath
                ) as! SeasonCell
                cell.configureWith(seasonNumber: season.number, isSelected: false)
                
                return cell
            case .series(let series):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SeriesCell.reuseIdentifier,
                    for: indexPath
                ) as! SeriesCell
                cell.configureWith(seasonNumber: series.number, movieImageId: series.link)
                
                return cell
            }
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            
            guard let section = Sections(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .seasons:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(80),
                    heightDimension: .absolute(40)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 0)
                
                return section
                
            case .series:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(327),
                    heightDimension: .absolute(224)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
                
                return section
            }
            
        }
    }
    
    private func registerCellsForCollectionView() {
        let layout = createLayout()
        
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollectionView.backgroundColor = .clear
        mainCollectionView.delegate = self
        
        mainCollectionView.register(SeasonCell.self,forCellWithReuseIdentifier: SeasonCell.reuseIdentifier)
        mainCollectionView.register(SeriesCell.self, forCellWithReuseIdentifier: SeriesCell.reuseIdentifier)
    }
    
    private func updateSnapshot(with series: [Series]) {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, CollectionItems>()
        snapshot.appendSections(Sections.allCases)
        
        snapshot.appendItems(movieSeasonsAndSeries.map { .season($0) }, toSection: .seasons)
        
        snapshot.appendItems(series.map { CollectionItems.series($0)}, toSection: .series)
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            dataSource.apply(snapshot, animatingDifferences: true)
            mainCollectionView
                .selectItem(
                    at: IndexPath(item: selectedSeasonIndex, section: 0),
                    animated: false,
                    scrollPosition: .centeredHorizontally
                )
        }
    }
}


extension SerialSeriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch selectedItem {
        case .season(let season):
            selectedSeasonIndex = indexPath.row
            updateSnapshot(with: season.videos)
        case .series(let series):
            let VC = PlayerViewController()
            VC.videoID = series.link
            VC.movieId = movieSeasonsAndSeries[indexPath.row].movieId
            VC.modalPresentationStyle = .fullScreen
            VC.modalTransitionStyle = .crossDissolve
            
            present(VC, animated: true)
            
        }
    }
}
