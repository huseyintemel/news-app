//
//  NewsCollectionViewCell.swift
//  news-app
//
//  Created by huseyin on 19.07.2023.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    lazy var newsImage = UIImageView()
    
    lazy var newsTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newsImage)
        addSubview(newsTitleLabel)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            
            newsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsTitleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor,constant: 10),
            newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            newsTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func set(article: Article) {
        guard let imageUrl = article.urlToImage else {
            print("Error")
            //newsImage.image = UIImage(named: "placeholder-news.jpg")
            return
        }
        ImageManager.shared.setImage(url: imageUrl, imageView: newsImage)
        newsTitleLabel.text = article.title
    }
    
}
