//
//  Article.swift
//  news-app
//
//  Created by huseyin on 14.07.2023.
//

import Foundation

struct Article: Decodable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
