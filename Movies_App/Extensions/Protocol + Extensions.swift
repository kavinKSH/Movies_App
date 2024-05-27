//
//  Protocol + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

extension MoviesDelegate {
    
    func didReciveSuccessWithMoviesData(of decodedData: MoviesData){}
    func didReciveFailureWithMoviesData(of error: String){}
    func didReciveSuccessWithNowPlayinData(of decodedData: NowPlayingMoviesData){}
    func didFailuresWithNowPlayingData(of error: String){}
}
