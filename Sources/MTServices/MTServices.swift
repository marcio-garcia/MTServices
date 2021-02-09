import Foundation
import Ivorywhite

public class MTServices {

    public static var shared = MTServices()

    private init() {}

    public func movieService(apiConfiguration: ApiConfiguration) -> MovieApi {
        let networkService = Ivorywhite.shared.service(debugMode: apiConfiguration.debugMode)
        return MovieService(apiConfiguration: apiConfiguration, service: networkService)
    }
}
