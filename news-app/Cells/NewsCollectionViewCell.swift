//
//  NewsCollectionViewCell.swift
//  news-app
//
//  Created by huseyin on 19.07.2023.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
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
    
    lazy var scrollIndicator: UIPageControl = {
        let indicator = UIPageControl(frame: .zero)
        indicator.currentPage = 0
        indicator.numberOfPages = 10
        indicator.currentPageIndicatorTintColor = .green
        indicator.pageIndicatorTintColor = .lightGray
        return indicator
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newsImage)
        addSubview(stackView)
        addStackViewArrangedSubViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addStackViewArrangedSubViews(){
        stackView.addArrangedSubview(newsTitleLabel)
        stackView.addArrangedSubview(scrollIndicator)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        scrollIndicator.currentPage = currentPage
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: newsImage.bottomAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func set(article: Article) {
        newsTitleLabel.text = article.title
        guard let imageUrl = article.urlToImage else {
            print("Error")
            newsImage.image = UIImage(named: "placeholder-news.jpg")
            return
        }
        ImageManager.shared.setImage(url: imageUrl, imageView: newsImage)
    }
    
}
