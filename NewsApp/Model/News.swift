//
//  News.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 19/7/24.
//

import Foundation

struct News: Codable {
    let author: String?
    let title: String
    let description: String
    let url: String
    let source: String
    let image: String?
    let category: String
    let language: String
    let country: String
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, source, image, category, language, country
        case publishedAt = "published_at"
    }
}

struct NewsResponse: Codable {
    let pagination: Pagination
    let data: [News]
}

struct Pagination: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let total: Int
}
