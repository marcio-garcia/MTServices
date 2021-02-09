//
//  MovieRequest.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 16/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Foundation
import Ivorywhite

class MovieRequest: Request, NetworkRequest {

    typealias ModelType = Movie
    typealias ErrorModelType = ErrorModel
    
    init?(id: Int, apiConfiguration: ApiConfiguration) {
        super.init()

        guard let baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        self.baseURL = baseURL
        self.path = "/3/movie/\(id)"
        self.httpMethod = .get
        self.encoding = .urlEnconding
        self.httpHeaders = [
            "Authorization": "Bearer \(apiConfiguration.apiToken)"
        ]
//        self.parameters = [
//            "query": keyword,
//            "page": page
//        ]
    }
    
    func parse(data: Data) -> ModelType? {
        let movie = try? JSONDecoder().decode(ModelType.self, from: data)
        return movie
    }

    func parseError(data: Data) -> ErrorModel? {
        return nil
    }
}
