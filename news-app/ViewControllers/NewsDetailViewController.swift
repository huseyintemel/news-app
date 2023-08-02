//
//  NewsDetailViewController.swift
//  news-app
//
//  Created by huseyin on 27.07.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    let article: Article
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var newsDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(newsImage)
        view.addSubview(titleLabel)
        view.addSubview(newsDetailLabel)
        setConstraints()
        
        titleLabel.text = article.title
        
        if let detailLabel = article.description {
            newsDetailLabel.text = detailLabel
        } else {
            newsDetailLabel.text = "No description"

        }
        
        if let imageUrl = article.urlToImage {
            ImageManager.shared.setImage(url: imageUrl, imageView: newsImage)
        } else {
            newsImage.image = UIImage(named: "placeholder-news.jpg")
            print("Detail page image error")
            return
        }
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 240),
        
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor,constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
    
            newsDetailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 16),
            newsDetailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            newsDetailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
        
        ])
    }
    
}
