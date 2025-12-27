//
//  NetworkManager.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 17.12.2025.
//

import Alamofire
import SVProgressHUD
import SDWebImage

enum responseURL: String {
    
    case signIn = "auth/V1/signin"
    case signUp = "auth/V1/signup"
    case favorites = "core/V1/favorite/"
}

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURLForImage: String = "http://apiozinshe.mobydev.kz/core/public/V1/show/"
    
    private init() {}
    
    private let baseURL: String = "http://apiozinshe.mobydev.kz/"
    private let headers: HTTPHeaders = ["Authorization": "Bearer \(ProfileStorage.shared.accessToken)"]
    
    func signIn(email: String, password: String, completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        let url = baseURL + responseURL.signIn.rawValue
        SVProgressHUD.show()
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).responseDecodable(of: SignInResponse.self) { response in
            switch response.result {
            case .success(let value):
                SVProgressHUD.dismiss()
                completion(.success(value))
            case .failure(let error):
                SVProgressHUD.dismiss()
                completion(.failure(error))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<SignInResponse, AFError>) -> Void) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        let url = baseURL + responseURL.signUp.rawValue
        SVProgressHUD.show()
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).responseDecodable(of: SignInResponse.self) { response in
            switch response.result {
            case .success(let value):
                SVProgressHUD.dismiss()
                completion(.success(value))
            case .failure(let error):
                SVProgressHUD.dismiss()
                completion(.failure(error))
            }
        }
    }
    
    func getFavorites(
        completion: @escaping (Result<[Movie], AFError>) -> Void
    ) {
        let url = baseURL + responseURL.favorites.rawValue
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: [Movie].self) { response in
            completion(response.result)
            }
        }
    
}
