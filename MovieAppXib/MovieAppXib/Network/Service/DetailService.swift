//
//  Service.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import Alamofire

protocol DetailServiceProtocol {
    func getSearchMovieList(id: String, onSuccess: @escaping (Detail?) -> Void, onError: @escaping (AFError) -> Void)
}

final class DetailService: DetailServiceProtocol {
    func getSearchMovieList(id: String, onSuccess: @escaping (Detail?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: "https://api.themoviedb.org/3/movie/\(id)?api_key=5f6d23c46111c10c12860cb3c77afd49&language=en-US") { (response: Detail) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
