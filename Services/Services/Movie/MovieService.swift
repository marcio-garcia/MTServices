//
//  MovieService.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 15/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Ivorywhite
import UIKit

class MovieService: MovieApi {

    var apiConfiguration: ApiConfiguration
    var service: NetworkService

    init(apiConfiguration: ApiConfiguration, service: NetworkService) {
        self.apiConfiguration = apiConfiguration
        self.service = service
    }

    func cancel(taskId: TaskId) {
        service.cancel(taskId: taskId)
    }

    @discardableResult
    func requestConfiguration(completion: @escaping (Configuration?, Error?) -> Void) -> TaskId? {
        guard let request = MovieConfigurationRequest(apiConfiguration: apiConfiguration) else {
            completion(nil, NetworkError.error(999, "Error constructing the MovieConfigurationRequest"))
            return nil
        }
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestGenres(completion: @escaping (GenreList?, Error?) -> Void) -> TaskId? {
        guard let request = MovieGenresRequest(apiConfiguration: apiConfiguration) else {
            completion(nil, NetworkError.error(999, "Error constructing the MovieGenresRequest"))
            return nil
        }
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestUpcomingMovies(page: Int, completion: @escaping (MovieList?, Error?) -> Void) -> TaskId? {
        guard let request = MovieUpcomingRequest(page: page, apiConfiguration: apiConfiguration) else {
            completion(nil, NetworkError.error(999, "Error constructing the MovieUpcomingRequest"))
            return nil
        }
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestSearchMovies(keywords: [String], page: Int, completion: @escaping (MovieList?, Error?) -> Void) -> TaskId? {
        let keyword = keywords.joined(separator: "+")
        guard let request = MovieSearchRequest(keyword: keyword, page: page, apiConfiguration: apiConfiguration) else {
            completion(nil, NetworkError.error(999, "Error constructing the MovieSearchRequest"))
            return nil
        }
        let requestId = service.request(request) { result in
            switch result {
            case .success(let response):
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        //let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    @discardableResult
    func requestMovie(id: Int, completion: @escaping (Movie?, Error?) -> Void) -> TaskId? {
        guard let request = MovieRequest(id: id, apiConfiguration: apiConfiguration) else {
            completion(nil, NetworkError.error(999, "Error constructing the MovieRequest"))
            return nil
        }
        let requestId = performRequest(request: request, completion: completion)
        return requestId
    }

    func downloadImage(with url: URL, completion: @escaping (UIImage?, Error?) -> Void) -> TaskId? {
        let requestId = performRequest(with: url) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }

            guard let image = UIImage(data: data) else {
                completion(nil, error)
                return
            }

            completion(image, nil)
        }
        return requestId
    }

    private func performRequest<T: NetworkRequest>(request: T,
                                                   completion: @escaping (T.ModelType?, Error?) -> Void) -> TaskId? {
        
        let id = service.request(request) { result in
            switch result {
            case .success(let response):
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        return id
    }

    private func performRequest(with url: URL,
                                completion: @escaping (Data?, Error?) -> Void) -> TaskId? {
        
        let requestId = service.request(with: url) { result in
            switch result {
            case .success(let response):
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        return requestId
    }
}
