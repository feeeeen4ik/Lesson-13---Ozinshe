//
//  SeasonModel.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 02.03.2026.
//

nonisolated struct Season: Codable, Hashable {
    let id: Int
    let movieId: Int
    let number: Int
    let videos: [Series]
}

nonisolated struct Series: Codable, Hashable {
    let id: Int
    let link: String
    let seasonId: Int
    let number: Int
}
