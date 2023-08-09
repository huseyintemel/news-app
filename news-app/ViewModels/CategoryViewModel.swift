//
//  CategoryViewModel.swift
//  news-app
//
//  Created by huseyin on 9.08.2023.
//

import UIKit

protocol CategoryViewModelDelegate {
    func viewModelDidUpdateData()
}

class CategoryViewModel {
    
    let categoryCollectionData = [
        Category(type: "business", name: "Business", image: UIImage(named: "business")!),
        Category(type: "sports", name: "Sports", image: UIImage(named: "sports")!),
        Category(type: "science", name: "Science", image: UIImage(named: "science")!),
        Category(type: "technology", name: "Technology", image: UIImage(named: "technology")!),
        Category(type: "entertainment", name: "Entertainment", image: UIImage(named: "entertainment")!),
    ]
    
    let apiKey = "7054e46161114bafaaeb518f3ddfaf09"
    let baseURL = "https://newsapi.org/v2"
    var delegate: CategoryViewModelDelegate?
    var categoryArticles : [Article] = []
    
    func numberOfCategories() -> Int {
        return categoryCollectionData.count
    }
    
    func collectionCategory(at item: Int) -> Category {
           return categoryCollectionData[item]
    }
    
    func numberOfNews() -> Int {
        return categoryArticles.count
    }
    
    func fetchCategoryData(category: String) async {
        let url = "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=7054e46161114bafaaeb518f3ddfaf09"
        NetworkManager.shared.request(News.self, url: url) { result in
            switch result {
            case .success(let newsAPIResponse):
                self.categoryArticles = newsAPIResponse.articles
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            self.delegate?.viewModelDidUpdateData()
        }
    }
    
    func article(at index: Int) -> Article {
           return categoryArticles[index]
    }
}
