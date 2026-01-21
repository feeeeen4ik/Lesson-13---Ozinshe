//
//  CategoryModel.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 18.01.2026.
//

nonisolated struct Category: Codable {
    let id: Int
    let name: String
    let fileId: String?
    let link: String?
    let movieCount: Int
}
