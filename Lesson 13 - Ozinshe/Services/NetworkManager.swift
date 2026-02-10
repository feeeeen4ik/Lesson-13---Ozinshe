//
//  NetworkManager.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 17.12.2025.
//

import Alamofire
import Foundation

enum ResponseURL: String {
    
    case signIn = "auth/V1/signin"
    case signUp = "auth/V1/signup"
    case favorites = "core/V1/favorite/"
    case profileData = "core/V1/user/profile"
    case changeProfileData = "core/V1/user/profile/"
    case changePassword = "core/V1/user/profile/changePassword"
    case getAllCategories = "core/V1/categories"
    case getMoviesWithParameters = "core/V1/movies/page"
    case getMoviesBySearch = "core/V1/movies/search"
    case getMoviesMain = "core/V1/movies_main"
    case getUserWatchHistory = "core/V1/history/userHistory"
    case getAllGenres = "core/V1/genres"
    case showResource = "core/public/V1/show/"
    case getCategoryAges = "core/V1/category-ages"
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
    
    func deleteFavoriteBy(id number: Int, completion: @escaping (AFError?) -> Void) {
        let parameters: [String: Int] = ["movieId": number]
        let url = baseURL + ResponseURL.favorites.rawValue
        
        AF.request(
            url,
            method: .delete,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).validate().response { response in
            completion(response.error)
        }
    }
    
    func getProfileData(completion: @escaping (Result<AccountData, AFError>) -> Void) {
        let url = baseURL + ResponseURL.profileData.rawValue
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: AccountData.self) { response in
            completion(response.result)
        }
    }
    
    func changeProfileData(userName: String, birthDate: String, phoneNumber: String, completion: @escaping(AFError?) -> Void) {
        let parameters: [String: String] = ["name": userName, "birthDate": birthDate, "phoneNumber": phoneNumber]
        let url = baseURL + ResponseURL.changeProfileData.rawValue
        
        AF.request(
            url,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).validate().response { response in
            completion(response.error)
        }
    }
    
    func changePassword(to newPassword: String, completion: @escaping (AFError?) -> Void) {
        let parameters: [String: String] = ["password": newPassword]
        let url = baseURL + ResponseURL.changePassword.rawValue
        
        AF.request(
            url,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).validate().response { response in
            completion(response.error)
        }
    }
    
    func getAllCategories(completion: @escaping (Result<[Categorie], AFError>) -> Void) {
        let url = baseURL + ResponseURL.getAllCategories.rawValue
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: [Categorie].self) { response in
            completion(response.result)
        }
    }
    
    func getMoviesByCategory(categoryId: Int, completion: @escaping (Result<[Movie], AFError>) -> Void) {
        let parameters: [String: Any] = ["categoryId": categoryId, "sortField": "name", "page": 0]
        let url = baseURL + ResponseURL.getMoviesWithParameters.rawValue
        
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.queryString,
            headers: headers
        ).validate().responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMoviesBySearch(query: String, completion: @escaping (Result<[Movie], AFError>) -> Void) {
        let parameters: [String: String] = ["search": query]
        let url = baseURL + ResponseURL.getMoviesBySearch.rawValue
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.queryString,
            headers: headers
        ).validate().responseDecodable(of: [Movie].self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMoviesMain(completion: @escaping (Result<[MoviesWrapper], AFError>) -> Void) {
        let url = baseURL + ResponseURL.getMoviesMain.rawValue
        
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: [MoviesWrapper].self) { response in
            completion(response.result)
        }
    }
    
    func getUserWatchHistory(
        completion: @escaping (Result<[Movie], AFError>) -> Void
    ) {
        let url = baseURL + ResponseURL.getUserWatchHistory.rawValue
        
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: [Movie].self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllGenres(completion: @escaping (Result<[Genre], AFError>) -> Void) {
        let url = baseURL + ResponseURL.getAllGenres.rawValue
        
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: [Genre].self) { response in
            completion(response.result)
        }
    }
    
    func getCategoryAges(completion: @escaping (Result<[Age], AFError>) -> Void) {
        let url = baseURL + ResponseURL.getCategoryAges.rawValue
        
        AF.request(
            url,
            method: .get,
            headers: headers
        ).validate().responseDecodable(of: [Age].self) { response in
            completion(response.result)
        }
    }
}
