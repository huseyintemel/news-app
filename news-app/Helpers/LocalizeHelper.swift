//
//  LocalizeHelper.swift
//  news-app
//
//  Created by huseyin on 10.08.2023.
//

import Foundation

class LocalizeHelper {
    static let shared = LocalizeHelper()
    
    private init() {}
    
    func localizeCategoryTitle(categoryType: String) -> String {
        let categoryMapping = [
            "business": "category_business",
            "sports": "category_sports",
            "science": "category_science",
            "technology": "category_technology",
            "entertainment": "category_entertainment"
        ]
        
        if let localizedKey = categoryMapping[categoryType] {
            return NSLocalizedString(localizedKey, comment: "")
        }
        
        return ""
    }
    
}
