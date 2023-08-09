//
//  CategoryViewModel.swift
//  news-app
//
//  Created by huseyin on 9.08.2023.
//

import UIKit

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
    var articles : [Article] = []
    
    func numberOfCategories() -> Int {
        return categoryCollectionData.count
    }
    
    func collectionCategory(at item: Int) -> Category {
           return categoryCollectionData[item]
    }
}
