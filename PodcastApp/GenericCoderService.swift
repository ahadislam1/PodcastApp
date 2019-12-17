//
//  GenericCoderService.swift
//  PodcastApp
//
//  Created by Ahad Islam on 12/17/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

class GenericCoderService {
    static let manager = GenericCoderService()
    private init() {}
    
    func getJSON<T: Decodable>(objectType: T.Type, with urlString: String, completionHandler: @escaping (Result<T, AppError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    func postJSON<T: Encodable>(object: T, with urlString: String, completionHandler: @escaping (Result<Data, AppError>) -> ()) {
        
        guard let encodedObject = try? JSONEncoder().encode(object) else {
            completionHandler(.failure(.invalidJSONResponse))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andHTTPBody: encodedObject, andMethod: .post) { result in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(.encodingError(error)))
            case .success(let data):
                completionHandler(.success(data))
            }
        }
    }
}
