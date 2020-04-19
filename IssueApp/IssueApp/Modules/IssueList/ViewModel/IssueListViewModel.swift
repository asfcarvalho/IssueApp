//
//  IssueListViewModel.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit

enum StatusEnum: String {
    case open,
    close
    
    static func getStatusEnum(_ statusEnum: String) -> String {
        switch statusEnum {
        case StatusEnum.open.rawValue:
            return "ABERTO"
        default:
            return "FECHADO"
        }
    }
}

struct IssueListViewModel {
    
    var issueList: [Issue]?
    
    struct Issue {
        let title: NSMutableAttributedString?
        let status: NSMutableAttributedString?
        let description: NSMutableAttributedString?
        let avatarURL: String?
        var data: NSMutableAttributedString?
        let url: String?
    }
    
    init(_ issueList: [IssueModel]) {
        
        let issueTemp = issueList.map({ issue in
            Issue(title: setupString("Title", issue.title), status: setupString("Status", StatusEnum.getStatusEnum(issue.state ?? "")) , description: setupString("Description", issue.body), avatarURL: issue.user?.avatarURL, data: setupString("Date", setupDate(issue.createdAt)) , url: issue.url)
        })
        
        self.issueList = issueTemp
    }
    
    private func setupDate(_ value: String?) -> String {
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let value = value, let date = formatDate.date(from: value) else {  return "" }
        
        formatDate.locale = Locale.current
        formatDate.dateStyle = .short
        formatDate.timeStyle = .medium
        let dateString = formatDate.string(from: date)
        
        return dateString
    }
    
    private func setupString(_ title: String, _ value: String?) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]))
        attributeString.append(NSAttributedString(string: ": \(value ?? "")"))
        
        return attributeString
    }
    
    func getIssue(_ index: Int) -> Issue? {
        return issueList?[index]
    }
}
