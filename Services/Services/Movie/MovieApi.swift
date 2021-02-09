//
//  MovieApi.swift
//  MovieTrack
//
//  Created by Marcio Garcia on 15/05/20.
//  Copyright © 2020 oxltech.com. All rights reserved.
//

import Ivorywhite
import UIKit

public protocol MovieApi {
    @discardableResult
    func requestConfiguration(completion: @escaping (Configuration?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestGenres(completion: @escaping (GenreList?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestUpcomingMovies(page: Int, completion: @escaping (MovieList?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestSearchMovies(keywords: [String], page: Int, completion: @escaping (MovieList?, Error?) -> Void) -> TaskId?
    @discardableResult
    func requestMovie(id: Int, completion: @escaping (Movie?, Error?) -> Void) -> TaskId?
    @discardableResult
    func downloadImage(with url: URL, completion: @escaping (UIImage?, Error?) -> Void) -> TaskId?
    func cancel(taskId: TaskId)
}
