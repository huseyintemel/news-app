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
    let apiKey = "7054e46161114bafaaeb518f3ddfaf09"
    let baseURL = "https://newsapi.org/v2"
    var delegate: NewsViewModelDelegate?
    var articles : [Article] = []
    var collectionArticles : [Article] = []
    var searchArticles: [Article] = []
    
    func numberOfNews() -> Int {
        return articles.count
    }
    
    func numberOfCollectionNews() -> Int {
        return collectionArticles.count
    }
    
    func numberOfSearchNews() -> Int {
        return searchArticles.count
    }
    
    func fetchData() async {
        let url = "\(baseURL)/top-headlines?country=us&sortBy=publishedAt&apiKey=\(apiKey)"
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
    
    func fetchCollectionData() async {
        let url = "\(baseURL)/top-headlines?sources=bbc-news&apiKey=\(apiKey)"
        NetworkManager.shared.request(News.self, url: url) { result in
            switch result {
            case .success(let newsAPIResponse):
                self.collectionArticles = newsAPIResponse.articles
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            self.delegate?.viewModelDidUpdateData()
        }
    }
    
    func searchArticlesData(query: String) async {
        let url = "\(baseURL)/everything?q=\(query)&language=en&pageSize=20&apiKey=\(apiKey)"
        NetworkManager.shared.request(News.self,url: url) { result in
            switch result {
            case .success(let newsAPIResponse):
                self.searchArticles = newsAPIResponse.articles
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            self.delegate?.viewModelDidUpdateData()
        }
    }
    
    func article(at index: Int) -> Article {
           return articles[index]
    }
    
    func collectionArticle(at item: Int) -> Article {
           return collectionArticles[item]
    }
    
    func searchArticle(at index: Int) -> Article {
           return searchArticles[index]
    }
}

