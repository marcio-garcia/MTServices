//
//  MovieResult.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 16/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Foundation

public struct MovieResult: Decodable {
    public var adult: Bool
    public var backdropPath: String?
    public var genreIds: [Int]
    public var id: Int
    public var originalLanguage: String
    public var originalTitle: String
    public var overview: String
    public var popularity: Double
    public var posterPath: String?
    public var releaseDate: Date?
    public var title: String
    public var video: Bool
    public var voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        adult = try container.decode(Bool.self, forKey: .adult)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        id = try container.decode(Int.self, forKey: .id)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        if let releaseDateString = try? container.decode(String.self, forKey: .releaseDate) {
            if let date = Date.date(from: releaseDateString, format: "yyyy-MM-dd") {
                releaseDate = date
            }
            else {
                releaseDate = Date()
            }
        } else {
            releaseDate = nil
        }
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    }
}

public struct MovieList: Decodable {
    public var totalResults: Int
    public var page: Int
    public var totalPages: Int
    public var dates: DateRange?
    public var results: [MovieResult]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case totalPages = "total_pages"
        case dates
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        dates = try? container.decode(DateRange.self, forKey: .dates)
        results = try container.decode([MovieResult].self, forKey: .results)
    }
}

