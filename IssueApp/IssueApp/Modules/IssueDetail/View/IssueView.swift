//
//  IssueView.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import UIKit

protocol IssueViewProtocol {
    func showIssue(_ url: String)
}

class IssueView: UIView {
    
    var delegate: IssueViewProtocol?
    private var url: String = ""
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()
    
    let bodyView = UIView()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    let avatarImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    let dateLabel = UILabel()
    
    let showButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 6
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.setTitle("Show Issue", for: UIControl.State.normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .white
        
        showButton.addTarget(self, action: #selector(showButtonAction), for: UIControl.Event.touchUpInside)
        
        browseAddSubviews([scrollView])
        
        scrollView.browseAddSubviews([bodyView])
        
        bodyView.browseAddSubviews([stackView])
        
        stackView.addArrangedSubview(avatarImage)
        stackView.addArrangedSubview(getSeparatorLine())
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(getSeparatorLine())
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(getSeparatorLine())
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(getSeparatorLine())
        stackView.addArrangedSubview(showButton)
        
        setupAchors()
    }
    
    private func setupAchors() {
        
        scrollView.browseEdgeToSuperView()
        
        bodyView
            .browseTopToSuperview()
            .browseBottomToBotton(of: scrollView)
            .browseWidthEqual(of: self)
            .browseCenterX(of: self)
        
        avatarImage.browseWidth(150).browseHeight(150)
        
        showButton.browseHeight(50)
        
        stackView
            .browseTopToTop(of: bodyView, margin: 16)
            .browseLeadingToLeading(of: bodyView, margin: 16)
            .browseTrailingToTrailing(of: bodyView, margin: 16)
            .browseBottomToBotton(of: bodyView, margin: 16)
    }
    
    public func setupView(_ issue: IssueListViewModel.Issue?) {
        
        titleLabel.attributedText = issue?.title
        bodyLabel.attributedText = issue?.description
        dateLabel.attributedText = issue?.data
        avatarImage.loadImageWith(url: issue?.avatarURL, showPlaceholder: true)
        
        url = issue?.url ?? ""
    }
    
    private func getSeparatorLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.browseHeight(0.5)
        return view
    }
    
    @objc private func showButtonAction() {
        delegate?.showIssue(url)
    }
}
