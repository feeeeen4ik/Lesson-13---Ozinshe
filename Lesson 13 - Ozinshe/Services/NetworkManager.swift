//
//  NetworkManager.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 17.12.2025.
//

import Alamofire

enum ResponseURL: String {
    
    case signIn = "auth/V1/signin"
    case signUp = "auth/V1/signup"
    case favorites = "core/V1/favorite/"
}

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURLForImage: String = "http://apiozinshe.mobydev.kz/core/public/V1/show/"
    
    private init() {}
    
    private let baseURL: String = "http://apiozinshe.mobydev.kz/"
    private var headers: HTTPHeaders = ["Authorization": "Bearer \(ProfileStorage.shared.accessToken)"]
    
    func signIn(email: String, password: String, completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        let url = baseURL + ResponseURL.signIn.rawValue
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).responseDecodable(of: SignInResponse.self) { response in
            completion(response.result)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        let url = baseURL + ResponseURL.signUp.rawValue
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).responseDecodable(of: SignInResponse.self) { response in
            completion(response.result)
        }
    }
    
    func getFavorites(
        completion: @escaping (Result<[Movie], AFError>) -> Void
    ) {
        let url = baseURL + ResponseURL.favorites.rawValue
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: [Movie].self) { response in
            completion(response.result)
            }
        }
    
}
