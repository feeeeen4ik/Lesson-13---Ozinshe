//
//  CategoryModel.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 18.01.2026.
//

nonisolated struct Age: Codable, Hashable {
    let id: Int
    let name: String
    let fileId: Int
    let link: String
    let movieCount: Int
}
