//
//  APIRequest.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import Foundation

class APIRequest {
    var baseURL: URL?
    var method = "GET"
    var parameters = [String: String]()
    
    init(_ baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func request(with baseURL: URL?) -> URLRequest? {
        guard let baseURL = baseURL else { return nil }
        var request = URLRequest(url: baseURL)
        request.httpMethod = method
        request.allHTTPHeaderFields = ["Accept" : "application/json"]
        return request
    }
}
