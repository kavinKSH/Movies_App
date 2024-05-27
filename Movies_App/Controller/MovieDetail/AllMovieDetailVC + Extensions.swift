//
//  AllMovieDetailVC + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 21/05/24.
//

import UIKit

extension AllMovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
            return 1
        case 6:
            return 1
        case 7:
            return 1
        case 8:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterCell.reusableIdentifier, for: indexPath) as? PosterCell else {return UITableViewCell()}
            if let movies = moviesDetailDict[Keys.movieDetails] {
                cell.set(movies)
            }
            cell.selectionStyle = .none
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reusableIdentfier, for: indexPath) as? DetailCell else {return UITableViewCell()}
            if let movies = moviesDetailDict[Keys.movieDetails] {
                cell.set(movies)
            }
            cell.tap.numberOfTapsRequired = 1
            cell.homePageLabel.isUserInteractionEnabled = true
            cell.homePageLabel.tag = indexPath.row
            cell.homePageLabel.addGestureRecognizer(cell.tap)
            cell.selectionStyle = .none
            return cell
            
        case 2:
            if moviesDetailDict[Keys.movieDetails]?.credits?.cast?.count ?? 0 >= 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TopCastCell.reusableIdentifier, for: indexPath) as? TopCastCell else {return UITableViewCell()}
                if let movieCast = moviesDetailDict[Keys.movieDetails]?.credits?.cast {
                    cell.setCastDatas(movieCast)
                }
                cell.selectionStyle = .none
                return cell
            }else {
                isVisibleCastCell = false
                return UITableViewCell()
            }
            
        case 3:
            if keywordDict[Keys.keyword]?.count ?? 0 >= 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordCell.reusableIdentifier, for: indexPath) as? KeywordCell else {return UITableViewCell()}
                if let keyword = keywordDict[Keys.keyword]{
                    cell.setKeywardsData(keyword)
                }
                cell.selectionStyle = .none
                return cell
            }else {
                isVisibleKeywordCell = false
                return UITableViewCell()
            }
            
        case 4:
            if moviesDetailDict[Keys.movieDetails]?.productionCompanies?.count ?? 0 >= 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductionCompanyCell.reusableIdentifier, for: indexPath) as? ProductionCompanyCell else {return UITableViewCell()}
                if let companies = moviesDetailDict[Keys.movieDetails]?.productionCompanies{
                    cell.setProductionCompanyDatas(companies)
                }
                cell.selectionStyle = .none
                return cell
            } else {
                isVisibleCompanyCell = false
                return UITableViewCell()
            }
            
        case 5:
            if reviewersDict[Keys.reviewers]?.results?.count ?? 0 >= 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewersCell.reuseIdenitifier, for: indexPath) as? ReviewersCell else {return UITableViewCell()}
                if let reviewers = reviewersDict[Keys.reviewers]?.results {
                    cell.setReviewersDatas(reviewers)
                }
                cell.selectionStyle = .none
                return cell
            } else {
                isVisibleReviewCell = false
                return UITableViewCell()
            }
            
        case 6:
            if videosDict[Keys.videos]?.results?.count ?? 0 >= 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: VideosCell.reusableIdentifier, for: indexPath) as? VideosCell else {return UITableViewCell()}
                if let videos = videosDict[Keys.videos]?.results {
                    cell.setVideosData(videos)
                }
                cell.selectionStyle = .none
                return cell
            }else {
                isVisibleVideosCell = false
                return UITableViewCell()
            }
            
        case 7:
            if collectionDict[Keys.collections]?.parts?.count ?? 0 >= 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCollectionsCell.reusableIdentifier, for: indexPath) as? MoviesCollectionsCell else {return UITableViewCell()}
                if let collections = collectionDict[Keys.collections] {
                    cell.setCollectionDatas(collections)
                }
                return cell
            }else {
                isVisibleCollectionCell = false
                return UITableViewCell()
            }
            
        case 8:
            if similerDict[Keys.similer]?.results?.count ?? 0 >= 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilerCell.reusableIdentifier, for: indexPath) as? SimilerCell else {return UITableViewCell()}
                if let similer = similerDict[Keys.similer]?.results {
                    cell.setSimilerDatas(similer)
                }
                cell.selectionStyle = .none
                return cell
            }else {
                isVisibleSimilerCell = false
                return UITableViewCell()
            }
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterCell.reusableIdentifier, for: indexPath) as? PosterCell else {return UITableViewCell()}
            if let movies = moviesDetailDict[Keys.movieDetails] {
                cell.set(movies)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 7 {
            let moviesId = moviesDetailDict[Keys.movieDetails]?.belongsToCollection?.id ?? 0
            navigationController?.pushViewController(CollectionVC(movieId: moviesId), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.2) {
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 230
        case 1:
            return UITableView.automaticDimension
        case 2:
            return isVisibleCastCell ? 150 : 0
        case 3:
            return isVisibleKeywordCell ? UITableView.automaticDimension : 0
        case 4:
            return isVisibleCompanyCell ? 100 : 0
        case 5:
            return isVisibleReviewCell ? 300 : 0
        case 6:
            return isVisibleVideosCell ? 250 : 0
        case 7:
            return isVisibleCollectionCell ? UITableView.automaticDimension : 0
        case 8:
            return isVisibleSimilerCell ? 300 : 0
        default:
            return 300
        }
    }
}
