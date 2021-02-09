//
//  MovieUpcomingRequest.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 16/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Foundation
import Ivorywhite

class MovieUpcomingRequest: Request, NetworkRequest {
    
    typealias ModelType = MovieList
    typealias ErrorModelType = ErrorModel
    
    init?(page: Int, apiConfiguration: ApiConfiguration) {
        super.init()
        
        guard let baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        self.baseURL = baseURL
        self.path = "/3/movie/upcoming"
        self.httpMethod = .get
        self.encoding = .urlEnconding
        self.httpHeaders = [
            "Authorization": "Bearer \(apiConfiguration.apiToken)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        self.parameters = [
            "page": page
        ]
    }
    
    func parse(data: Data) -> ModelType? {
                
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        let movieList = try? JSONDecoder().decode(ModelType.self, from: data)
        return movieList
    }

    func parseError(data: Data) -> ErrorModelType? {
        return nil
    }
}
