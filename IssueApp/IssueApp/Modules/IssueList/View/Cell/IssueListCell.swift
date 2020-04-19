//
//  IssueListCell.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit

class IssueListCell: UITableViewCell {
    
    var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    var status = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(status)
        
        browseAddSubviews([stackView])
        
        stackView.browseEdgeToSuperView(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    func setupFetch(_ issue: IssueListViewModel.Issue?) {
        title.attributedText = issue?.title
        status.attributedText = issue?.status
    }
}
