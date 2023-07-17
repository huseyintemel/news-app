//
//  News.swift
//  news-app
//
//  Created by huseyin on 14.07.2023.
//

import Foundation

struct News: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
