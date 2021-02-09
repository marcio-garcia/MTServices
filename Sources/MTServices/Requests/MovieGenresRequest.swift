//
//  MovieGenresRequest.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 16/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Foundation
import Ivorywhite

class MovieGenresRequest: Request, NetworkRequest {

    typealias ModelType = GenreList
    typealias ErrorModelType = ErrorModel
    
    init?(apiConfiguration: ApiConfiguration) {
        super.init()

        guard let baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        self.baseURL = baseURL
        self.path = "/3/genre/movie/list"
        self.httpMethod = .get
        self.encoding = .urlEnconding
        self.httpHeaders = [
            "Authorization": "Bearer \(apiConfiguration.apiToken)",
            "Content-Type": "application/json;charset=utf-8"
        ]
    }
    
    func parse(data: Data) -> ModelType? {
        let genreList = try? JSONDecoder().decode(ModelType.self, from: data)
        return genreList
    }

    func parseError(data: Data) -> ErrorModel? {
        return nil
    }
}
