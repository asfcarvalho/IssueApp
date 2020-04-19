//
//  IssueDataSource.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit

class IssueDataSource {
    
    static var share = IssueDataSource()
    
    private let url = "https://api.github.com/repos/apple/swift/issues"
    
    func fetchIssueList(callback: @escaping (Result<[IssueModel], Error>) -> Void) {
        
        guard let baseUrl = URL(string: url) else { return }
        
        let apiRequest = APIRequest(baseUrl)
        
        APICalling<[IssueModel]>().fetch(apiRequest: apiRequest) { result in
            switch result {
            case .failure(let error):
                callback(.failure(error))
                break
            case .success(let issueList):
                callback(.success(issueList))
                break
            }
        }
    }
}
