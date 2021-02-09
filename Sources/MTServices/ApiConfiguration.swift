//
//  ApiConfiguration.swift
//  MovieApi
//
//  Created by Marcio Garcia on 30/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

public enum ApiEnvironment {
    case development
    case staging
    case production
}

public protocol ApiConfiguration {
    var environment: ApiEnvironment { get set }
    var baseUrl: String { get set }
    var apiToken: String { get set }
    var debugMode: Bool { get set }
}
