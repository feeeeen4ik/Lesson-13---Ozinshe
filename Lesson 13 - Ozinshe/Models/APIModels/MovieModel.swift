//
//  MovieModel.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 27.12.2025.
//

nonisolated struct Movie: Codable, Hashable {
    let id: Int
    let movieType: String
    let name: String
    let keyWords: String
    let description: String
    let year: Int
    let trend: Bool
    let timing: Int
    let director: String
    let producer: String
    let poster: Poster
    let video: Video?
    let watchCount: Int
    let seasonCount: Int
    let seriesCount: Int
    let createdDate: String
    let lastModifiedDate: String
    let screenshots: [Screenshot]
    let categoryAges: [CategoryAges]
    let genres: [Genre]
    let categories: [Categorie]
    let favorite: Bool
}

nonisolated struct MoviesResponse: Decodable, Hashable {
    let content: [Movie]
}

nonisolated struct MoviesWrapper: Decodable, Hashable {
    let id: Int
    let movie: Movie
}

struct Poster: Codable, Hashable {
    let id: Int
    let link: String
    let fileId: Int
    let movieId: Int
}

struct Video: Codable, Hashable {
    let id: Int
    let link: String
    let seasonId: Int?
    let number: Int
}

struct Screenshot: Codable, Hashable {
    let id: Int
    let link: String
    let fileId: Int
    let movieId: Int
}

struct CategoryAges: Codable, Hashable {
    let id: Int
    let name: String
    let fileId: Int
    let link: String
    let movieCount: Int?
}

struct Genre: Codable, Hashable {
    let id: Int
    let name: String
    let fileId: Int
    let link: String
    let movieCount: Int?
}

nonisolated struct Categorie: Codable, Hashable {
    let id: Int
    let name: String
    let fileId: Int?
    let link: String?
    let movieCount: Int?
}
