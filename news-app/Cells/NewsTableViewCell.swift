//
//  NewsTableViewCell.swift
//  news-app
//
//  Created by huseyin on 17.07.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    lazy var newsImage = UIImageView()

    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    lazy var sourceLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(newsImage)
        addSubview(titleLabel)
        addSubview(labelStack)
        addLabelStackSubViews()
        configureNewsImage()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        guard let imageUrl = article.urlToImage else {
            print("Image url is not available for this article.")
            newsImage.image = UIImage(named: "placeholder-news.jpg")
            return
        }
        ImageManager.shared.setImage(url: imageUrl, imageView: newsImage)
        titleLabel.text = article.title
        let formattedTime = article.publishedAt.getTimeAgo()
        timeLabel.text = formattedTime
        sourceLabel.text = article.source.name
    }
    
    func configureNewsImage() {
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.layer.cornerRadius = 10
        newsImage.clipsToBounds = true
    }
    
    func addLabelStackSubViews() {
        labelStack.addArrangedSubview(timeLabel)
        labelStack.addArrangedSubview(sourceLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            //newsImage
            newsImage.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            newsImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 8),
            newsImage.heightAnchor.constraint(equalToConstant: 240),
            
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor,constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            
            //labelStack
            labelStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)

        ])
    }
}
