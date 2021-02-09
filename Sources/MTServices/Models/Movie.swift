//
//  Movie.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 16/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Foundation

public struct Collection: Decodable {
    public var id: Int
    public var name: String
    public var posterPath: String
    public var backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
    }
}

public struct ProductionCompany: Decodable {
    public var id: Int
    public var logoPath: String?
    public var name: String
    public var originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

public struct ProductionCountry: Decodable {
    public var code: String
    public var name: String
    
    enum CodingKeys: String, CodingKey {
        case code = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguage: Decodable {
    public var code: String
    public var name: String

    enum CodingKeys: String, CodingKey {
        case code = "iso_639_1"
        case name
    }
}

public struct DateRange: Decodable {
    public var maximum: Date
    public var minimum: Date
    
    enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let maximumString = try container.decode(String.self, forKey: .maximum)
        if let date = Date.date(from: maximumString, format: "yyyy-MM-dd") {
            maximum = date
        }
        else {
            maximum = Date()
        }
        let minimumString = try container.decode(String.self, forKey: .minimum)
        if let date = Date.date(from: minimumString, format: "yyyy-MM-dd") {
            minimum = date
        }
        else {
            minimum = Date()
        }
    }
}

public struct Movie: Decodable {
    
    public var adult: Bool?
    public var backdropPath: String?
    public var collections: [Collection]?
    public var budget: Int?
    public var genres: [Genre]?
    public var homepage: String?
    public var id: Int?
    public var imdbId: String?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var productionCompanies: [ProductionCompany]?
    public var productionCountries: [ProductionCountry]?
    public var releaseDate: Date?
    public var revenue: Double?
    public var runtime: Int?
    public var spokenLanguage: [SpokenLanguage]?
    public var status: String?
    public var tagline: String?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case collections = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguage = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try? container.decode(Bool.self, forKey: .adult)
        self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        self.collections = try? container.decode([Collection].self, forKey: .collections)
        self.budget = try? container.decode(Int.self, forKey: .budget)
        self.genres = try? container.decode([Genre].self, forKey: .genres)
        self.homepage = try? container.decode(String.self, forKey: .homepage)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.imdbId = try? container.decode(String.self, forKey: .imdbId)
        self.originalLanguage = try? container.decode(String.self, forKey: .originalLanguage)
        self.originalTitle = try? container.decode(String.self, forKey: .originalTitle)
        self.overview = try? container.decode(String.self, forKey: .overview)
        self.popularity = try? container.decode(Double.self, forKey: .popularity)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.productionCompanies = try? container.decode([ProductionCompany].self, forKey: .productionCompanies)
        self.productionCountries = try? container.decode([ProductionCountry].self, forKey: .productionCountries)
        self.revenue = try? container.decode(Double.self, forKey: .revenue)
        self.runtime = try? container.decode(Int.self, forKey: .runtime)
        self.spokenLanguage = try? container.decode([SpokenLanguage].self, forKey: .spokenLanguage)
        self.status = try? container.decode(String.self, forKey: .status)
        self.tagline = try? container.decode(String.self, forKey: .tagline)
        self.title = try? container.decode(String.self, forKey: .title)
        self.video = try? container.decode(Bool.self, forKey: .video)
        self.voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try? container.decode(Int.self, forKey: .voteCount)
        
        if let releaseDateString = try? container.decode(String.self, forKey: .releaseDate) {
            if let date = Date.date(from: releaseDateString, format: "yyyy-MM-dd") {
                self.releaseDate = date
            }
            else {
                self.releaseDate = Date()
            }
        }
    }
}
