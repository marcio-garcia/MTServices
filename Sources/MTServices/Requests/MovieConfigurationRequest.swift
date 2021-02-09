//
//  MovieConfigurationRequest.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 15/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Foundation
import Ivorywhite

class MovieConfigurationRequest: Request, NetworkRequest {

    typealias ModelType = Configuration
    typealias ErrorModelType = ErrorModel
    
    init?(apiConfiguration: ApiConfiguration) {
        super.init()

        guard let baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }
        
        self.baseURL = baseURL
        self.path = "/3/configuration"
        self.httpMethod = .get
        self.httpHeaders = [
            "Authorization": "Bearer \(apiConfiguration.apiToken)",
            "Content-Type": "application/json;charset=utf-8"
        ]
    }
    
    func parse(data: Data) -> ModelType? {
        let configuration = try? JSONDecoder().decode(ModelType.self, from: data)
        return configuration
    }

    func parseError(data: Data) -> ErrorModel? {
        return nil
    }
}
