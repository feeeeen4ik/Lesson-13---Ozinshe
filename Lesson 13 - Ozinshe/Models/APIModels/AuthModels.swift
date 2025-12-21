//
//  AuthModels.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 17.12.2025.
//

nonisolated struct SignInResponse: Decodable, Sendable {
    let id: Int
    let username: String
    let email: String
    let roles: [String]
    let tokenType: String
    let accessToken: String
}
