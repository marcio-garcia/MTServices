//
//  Configuration.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 15/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

public enum BackdropSize: String {
    case w300
    case w780
    case w1280
    case original
}

public enum LogoSize: String {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

public enum PosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

public enum ProfileSize: String {
    case w45
    case w185
    case w632
    case original
}

public enum StillSize: String {
    case w92
    case w185
    case w300
    case original
}

public struct ImageConfiguration: Decodable {
    public var baseUrl: String
    public var secureBaseUrl: String
    public var backdropSizes: [String: BackdropSize]
    public var logoSizes: [String: LogoSize]
    public var posterSizes: [String: PosterSize]
    public var profileSizes: [String: ProfileSize]
    public var stillSizes: [String: StillSize]
    
    enum CodingKeys: String, CodingKey {
        case baseUrl        = "base_url"
        case secureBaseUrl  = "secure_base_url"
        case backdropSizes  = "backdrop_sizes"
        case logoSizes      = "logo_sizes"
        case posterSizes    = "poster_sizes"
        case profileSizes   = "profile_sizes"
        case stillSizes     = "still_sizes"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseUrl = try container.decode(String.self, forKey: .baseUrl)
        secureBaseUrl = try container.decode(String.self, forKey: .secureBaseUrl)
        
        let backdropSizesString = try container.decode([String].self, forKey: .backdropSizes)
        var backdropSizes: [String: BackdropSize] = [:]
        backdropSizesString.forEach { (sizeString) in
            if let size = BackdropSize(rawValue: sizeString) {
                backdropSizes[sizeString] = size
            }
        }
        self.backdropSizes = backdropSizes
        
        let logoSizesString = try container.decode([String].self, forKey: .logoSizes)
        var logoSizes: [String: LogoSize] = [:]
        logoSizesString.forEach { (sizeString) in
            if let size = LogoSize(rawValue: sizeString) {
                logoSizes[sizeString] = size
            }
        }
        self.logoSizes = logoSizes
        
        let posterSizesString = try container.decode([String].self, forKey: .posterSizes)
        var posterSizes: [String: PosterSize] = [:]
        posterSizesString.forEach { (sizeString) in
            if let size = PosterSize(rawValue: sizeString) {
                posterSizes[sizeString] = size
            }
        }
        self.posterSizes = posterSizes
        
        let profileSizesString = try container.decode([String].self, forKey: .profileSizes)
        var profileSizes: [String: ProfileSize] = [:]
        profileSizesString.forEach { (sizeString) in
            if let size = ProfileSize(rawValue: sizeString) {
                profileSizes[sizeString] = size
            }
        }
        self.profileSizes = profileSizes
        
        let stillSizesString = try container.decode([String].self, forKey: .stillSizes)
        var stillSizes: [String: StillSize] = [:]
        stillSizesString.forEach { (sizeString) in
            if let size = StillSize(rawValue: sizeString) {
                stillSizes[sizeString] = size
            }
        }
        self.stillSizes = stillSizes
        
    }
}

public struct Configuration: Decodable {
    public var images: ImageConfiguration
    public var change_keys: [String]
}
