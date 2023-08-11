//
//  NewsTablePlaceHolderCell.swift
//  news-app
//
//  Created by huseyin on 11.08.2023.
//

import UIKit

class NewsTablePlaceHolderCell: UITableViewCell {
    
    let placeHolderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray.withAlphaComponent(0.4)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var placeHolderTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.backgroundColor = .gray.withAlphaComponent(0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    lazy var placeHolderTimeLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray.withAlphaComponent(0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    lazy var placeHolderSourceLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray.withAlphaComponent(0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var placeHolderStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .gray.withAlphaComponent(0.4)
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(placeHolderImageView)
        contentView.addSubview(placeHolderTitle)
        contentView.addSubview(placeHolderStack)
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPlaceHolderStackSubViews() {
        placeHolderStack.addArrangedSubview(placeHolderTimeLabel)
        placeHolderStack.addArrangedSubview(placeHolderSourceLabel)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            placeHolderImageView.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            placeHolderImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            placeHolderImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 8),
            placeHolderImageView.heightAnchor.constraint(equalToConstant: 240),
            
            placeHolderTitle.topAnchor.constraint(equalTo: placeHolderImageView.bottomAnchor,constant: 8),
            placeHolderTitle.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            placeHolderTitle.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            placeHolderTitle.heightAnchor.constraint(equalToConstant: 80),
            
            placeHolderTimeLabel.heightAnchor.constraint(equalToConstant: 10),
            placeHolderSourceLabel.heightAnchor.constraint(equalToConstant: 10),
            
            placeHolderStack.topAnchor.constraint(equalTo: placeHolderTitle.bottomAnchor,constant: 8),
            placeHolderStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            placeHolderStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            placeHolderStack.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
        ])
    }
}
