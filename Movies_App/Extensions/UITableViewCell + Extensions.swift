//
//  ViewController + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

extension NowPlayingTableViewCell: UICollectionViewDelegateFlowLayout {
    func createTrendingCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)),repeatingSubitem: item,count: 1)
                
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
            }
            return nil
        }
    }
    
}

extension UpcomingMoviesCell {
    
}

extension NowPlayingTableViewCell {
    
}

extension TVTableCell {
    
}

extension PopularCell {
    
}

extension MoviesTableViewCell {
    
}

extension TopRatedTableViewCell {
    
}
