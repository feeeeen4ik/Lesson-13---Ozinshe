//
//  AccountModel.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 05.01.2026.
//

nonisolated struct AccountData: Codable {
    let id: Int
    let user: User
    let name: String
    let phoneNumber: String
    let birthDate: String?
    let language: String?
}

struct User: Codable {
    let id: Int
    let email: String
}
