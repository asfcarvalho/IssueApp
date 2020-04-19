//
//  IssueModelSpecs.swift
//  IssueAppTests
//
//  Created by Anderson F Carvalho on 19/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import IssueApp

class IssueViewModelSpecs: QuickSpec {
    
    override func spec() {
         
        var issueListViewModel: IssueListViewModel?
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        describe("The Issue ViewModel") {
            context("Can be created with valid JSON") {
                afterEach {
                    issueListViewModel = nil
                }
                beforeEach {
                    
                    
                    let createdAt = formatDate.string(from: Date())
                    
                    let issue = [IssueModel(title: "Issue Title", state: "open", body: "Issue Body", url: nil, createdAt: createdAt, user: nil)]
                    
                    issueListViewModel = IssueListViewModel(issue)
                }
                
                it("can parse the correct date time ") {
                    formatDate.locale = Locale.current
                    formatDate.dateStyle = .short
                    formatDate.timeStyle = .medium
                    let date = formatDate.string(from: Date())
                    expect(issueListViewModel?.issueList?.first?.data?.string).to(equal("Date: \(date)"))
                }
                
                it("can parse the correct title") {
                    expect(issueListViewModel?.issueList?.first?.title?.string).to(equal("Title: Issue Title"))
                }
                
                it("can parse the correct description") {
                    expect(issueListViewModel?.issueList?.first?.description?.string).to(equal("Description: Issue Body"))
                }
                
                it("can parse the correct state") {
                    expect(issueListViewModel?.issueList?.first?.status?.string).to(equal("Status: ABERTO"))
                }
            }
        }
    }
}
