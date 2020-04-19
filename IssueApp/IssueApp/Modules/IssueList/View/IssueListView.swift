//
//  IssueListView.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit

protocol IssuelistViewProdotol {
    func selectedRow(_ issue: IssueListViewModel.Issue?)
}

class IssueListView: UIView {
    
    private let cellName = "cell"
    private var issueListViewModel: IssueListViewModel?
    var delegate: IssuelistViewProdotol?
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IssueListCell.self, forCellReuseIdentifier: cellName)
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = .white
        
        browseAddSubviews([tableView])
        
        tableView.browseEdgeToSuperView()
                
        fetchData()
    }
    
    private func fetchData() {
        IssueDataSource.share.fetchIssueList { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                break
            case .success(let issue):
                self?.issueListViewModel = IssueListViewModel(issue)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                break
            }
        }
    }
}

extension IssueListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issueListViewModel?.issueList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? IssueListCell else {
            return UITableViewCell()
        }
        
        cell.awakeFromNib()
        cell.setupFetch(issueListViewModel?.getIssue(indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        delegate?.selectedRow(issueListViewModel?.getIssue(indexPath.row))
    }
}
