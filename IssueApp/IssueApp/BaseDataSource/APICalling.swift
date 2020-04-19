//
//  APICalling.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import Foundation

enum Err: Error {
    case Default
}

class APICalling<T: Codable> {
    typealias Callback = (Result<T, Error>) -> Void
    
    func fetch(apiRequest: APIRequest, callBack: @escaping Callback) {
        
        guard let request = apiRequest.request(with: apiRequest.baseURL) else {
            callBack(.failure(Err.Default))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                callBack(.failure(error ?? Err.Default))
                return
                
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                callBack(.success(model))
                
            } catch let error {
                callBack(.failure(error))
            }
            
        }
        task.resume()
        
    }
}
