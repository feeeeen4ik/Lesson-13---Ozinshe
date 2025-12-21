//
//  NetworkManager.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 17.12.2025.
//

import Alamofire
import SVProgressHUD

enum responseURL: String {
    
    case signIn = "auth/V1/signin"
    case signUp = "auth/V1/signup"
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let baseURL: String = "http://apiozinshe.mobydev.kz/"
    
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
    
    
}
