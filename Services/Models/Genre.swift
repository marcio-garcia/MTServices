//
//  Genre.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 16/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

public struct Genre: Decodable {
    public var id: Int
    public var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

public struct GenreList: Decodable {
    public var genres: [Genre]
}
