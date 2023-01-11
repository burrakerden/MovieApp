//
//  Service.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import Alamofire

protocol ServiceProtocol {
    func getSearchMovieList(text: String, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Service: ServiceProtocol {
    func getSearchMovieList(text: String, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: "https://api.themoviedb.org/3/movie/now_playing?api_key=5f6d23c46111c10c12860cb3c77afd49&language=en-US") { (response: Movie) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}

final class SearchService: ServiceProtocol {
    func getSearchMovieList(text: String, onSuccess: @escaping (Movie?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: "https://api.themoviedb.org/3/search/movie?api_key=5f6d23c46111c10c12860cb3c77afd49&language=en-US&query=\(text)") { (response: Movie) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
