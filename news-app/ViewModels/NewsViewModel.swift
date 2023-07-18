//
//  NewsViewModel.swift
//  news-app
//
//  Created by huseyin on 18.07.2023.
//

import UIKit

protocol NewsViewModelDelegate {
    func viewModelDidUpdateData()
}

class NewsViewModel {
    var delegate: NewsViewModelDelegate?
    var articles : [Article] = []
    
    func numberOfNews() -> Int {
        return articles.count
    }
    
    func fetchData() async {
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=7054e46161114bafaaeb518f3ddfaf09"
        NetworkManager.shared.request(News.self, url: url) { result in
            switch result {
            case .success(let newsAPIResponse):
                self.articles = newsAPIResponse.articles
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            self.delegate?.viewModelDidUpdateData()
        }
    }
    
    func article(at index: Int) -> Article {
           return articles[index]
    }
    
}

