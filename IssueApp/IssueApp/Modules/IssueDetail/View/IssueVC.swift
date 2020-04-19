//
//  IssueVC.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit

class IssueVC: UIViewController {
    
    var issueView: IssueView?
    
    init(_ issue: IssueListViewModel.Issue?) {
        super.init(nibName: nil, bundle: nil)
        
        issueView = IssueView(frame: view.frame)
        issueView?.delegate = self
        issueView?.setupView(issue)
        view = issueView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Issue Detail"
    }

}

extension IssueVC: IssueViewProtocol {
    func showIssue(_ url: String) {
        
        guard let isUrl = URL(string: url) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(isUrl) {
            UIApplication.shared.open(isUrl, options: [:], completionHandler: nil)
        }
    }
}
