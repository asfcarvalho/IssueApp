//
//  IssueListVC.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit

class IssueListVC: UIViewController {
    
    var issueListView: IssueListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        issueListView = IssueListView(frame: view.frame)
        issueListView?.delegate = self
        view = issueListView
        
        title = "Issue List"
    }
}

extension IssueListVC: IssuelistViewProdotol {
    func selectedRow(_ issue: IssueListViewModel.Issue?) {
        
        let issueVC = IssueVC(issue)
        navigationController?.pushViewController(issueVC, animated: false)
    }
    
}
