//
//  MoviesViewController + Extentions.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
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
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableViewCell.reusableIdentifier, for: indexPath) as? NowPlayingTableViewCell else {return UITableViewCell()}
            if let playing = nowPlayingDict["NowPlaying"] {
                cell.setNowPlayingDatas(playing)
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.reusableIdentifier, for: indexPath) as? TrendingCell else {return UITableViewCell()}
            if let trending = trendingDict["Trending"] {
                cell.setTrendingDatas(trending)
            }
            cell.selectionStyle = .none
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCell.reusableIdentifier, for: indexPath) as? PopularCell else {return UITableViewCell()}
            if let popular = popularDict["Popular"] {
                cell.setPopularDatas(popular)
            }
            cell.selectionStyle = .none
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.reusableIdentifier, for: indexPath) as? TopRatedTableViewCell else {return UITableViewCell()}
            if let topRated = topRatedDict["TopRated"] {
                cell.setTopRatedDatas(topRated)
            }
            cell.selectionStyle = .none
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMoviesCell.reusableIdentifier, for: indexPath) as? UpcomingMoviesCell else {return UITableViewCell()}
            if let upcomoing = upcomingDict["Upcoming"] {
                cell.setUpcomingDatas(upcomingDatas: upcomoing)
            }
            cell.selectionStyle = .none
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TVTableCell.reusableIdentifier, for: indexPath) as? TVTableCell else {return UITableViewCell()}
            if let tvDatas = tvDict["TVShows"] {
                cell.setTVDatas(tvDatas)
            }
            cell.selectionStyle = .none
            return cell
            
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reusableIdentifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
            if let moviesDatas = moviesDict["Movies"] {
                cell.setMoviesDatas(moviesDatas)
            }
            cell.selectionStyle = .none
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reusableIdentifier, for: indexPath) as? MoviesTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}

//MARK: - UITableView Delegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 550
        case 1:
            return UITableView.automaticDimension
        case 2:
            return UITableView.automaticDimension
        case 3:
            return UITableView.automaticDimension
        case 4:
            return UITableView.automaticDimension
        case 5:
            return UITableView.automaticDimension
        default:
            return 380
        }
    }
}

//extension HomeViewController {
//    @objc func HorizantalScrollAnimation(_ timer1: Timer) {
//        if let coll  = collectionView {
//            for cell in coll.visibleCells {
//                let indexPath: IndexPath? = coll.indexPath(for: cell)
//                if ((indexPath?.item ?? 0) < nowPlayingArr.count - 1){
//                    let indexPath1: IndexPath?
//                    indexPath1 = IndexPath.init(row: (indexPath?.row) ?? 0 + 1, section: (indexPath?.section)!)
//
//                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
//                }
//                else{
//                    let indexPath1: IndexPath?
//                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
//                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
//                }
//            }
//        }
//    }

//    func startTimer() {
//        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(HorizantalScrollAnimation), userInfo: nil, repeats: true)
//    }
//}




