//
//  Services.swift
//  Services
//
//  Created by Marcio Garcia on 01/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import Foundation
import Ivorywhite

public class Services {
    
    public static var shared = Services()
    
    private init() {}
    
    public func movieService(apiConfiguration: ApiConfiguration) -> MovieApi {
        let networkService = Ivorywhite.shared.service(debugMode: apiConfiguration.debugMode)
        return MovieService(apiConfiguration: apiConfiguration, service: networkService)
    }
}
