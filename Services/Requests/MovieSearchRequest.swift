//
//  MovieSearchRequest.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 16/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Foundation
import Ivorywhite

class MovieSearchRequest: Request, NetworkRequest {

    typealias ModelType = MovieList
    typealias ErrorModelType = ErrorModel
    
    init?(keyword: String, page: Int, apiConfiguration: ApiConfiguration) {
        super.init()

        guard let baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        self.baseURL = baseURL
        self.path = "/3/search/movie"
        self.httpMethod = .get
        self.encoding = .urlEnconding
        self.httpHeaders = [
            "Authorization": "Bearer \(apiConfiguration.apiToken)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        self.parameters = [
            "query": keyword,
            "page": page
        ]
    }
    
    func parse(data: Data) -> ModelType? {
        do {
            let movieList = try JSONDecoder().decode(ModelType.self, from: data)
            return movieList
        } catch let error as DecodingError {
            switch error {
            case .dataCorrupted(let context):
                print("Context:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .typeMismatch(let type, let context):
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            case .valueNotFound(let type, let context):
                print("value '\(type)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            @unknown default:
                print("Unknown decoding error")
            }
        } catch {
            print("Decoding error: \(error.localizedDescription)")
        }
        return nil
    }

    func parseError(data: Data) -> ErrorModel? {
        return nil
    }
}
