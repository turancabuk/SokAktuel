//
//  Webservice.swift
//  Aktuel
//  Created by Turan Çabuk on 28.11.2022.

import Foundation

protocol WebserviceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: AktuelAPICall, completion: @escaping (Result <T, Error>) -> Void)
}

final class WebService: WebserviceProtocol {
    
    func fetch<T: Codable>(response: T.Type, with path: AktuelAPICall, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = URLRequest(url: path.url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
protocol WebServiceAdapterProtocol {
    func getProducts(completion: @escaping (Result<Aktuel, Error>) -> Void)
}
final class WebServiceAdapter: WebServiceAdapterProtocol {
    
    let webService: WebserviceProtocol
    
    init(webService: WebserviceProtocol) {
        self.webService = webService
    }
    func getProducts(completion: @escaping (Result<Aktuel, Error>) -> Void) {
        webService.fetch(response: Aktuel.self, with: .getAktuel, completion: completion)
    }
}

class BaseRequest {
    init() {}
}

class UserRequest: BaseRequest {
    var path : String = "/users/me"
}

