//
//  HTTPClient.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

class HTTPClient {
    
    static let shared = HTTPClient()
    
    let imagePath = "https://image.tmdb.org/t/p/w500"
    
    func networking(endpoints: Endpoints ,competion: @escaping(Result<Data, NetworkingError>)->Void) {
        
        guard let url = endpoints.url else {
            competion(.failure(.badURL))
            return
        }
        print("URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                competion(.failure(.errorValues(error: error)))
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else {
                competion(.failure(.pageNotFound))
                return
            }
            switch response.statusCode {
            case 200:
                competion(.success(data))
            case 404:
                competion(.failure(.pageNotFound))
            case 500:
                competion(.failure(.internalServerError))
            default:
                competion(.success(data))
            }
        }
        task.resume()
    }
    
    func downloadNowPlayingImages(url: URL?, completion: @escaping(UIImage?)->Void){
        let cache     = NSCache<NSURLRequest, UIImage>()
        let cacheKey  = NSURLRequest(url: url!)
        
        if let images = cache.object(forKey: cacheKey) {
            completion(images)
        }
        guard let url = url else {
            return completion(nil)
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
            guard let image = UIImage(data: data) else {return completion(nil) }
            cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
    func downloadMoviesImages(url: URL?, completion: @escaping(UIImage?)->Void){
        let cache     = NSCache<NSURLRequest, UIImage>()
        let cacheKey  = NSURLRequest(url: url!)
        
        if let images = cache.object(forKey: cacheKey) {
            completion(images)
        }
        guard let url = url else {
            return completion(nil)
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
            guard let image = UIImage(data: data) else {return completion(nil) }
            cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}




