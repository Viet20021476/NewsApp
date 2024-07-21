//
//  Request.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

enum Request {
    case fetchNews(accessKey: String, sources: String?, categories: String?, countries: String?, languages: String?, keywords: String?, date: String?, sort: String?, limit: Int?, offset: Int?)
    
    var path: String {
        switch self {
        case .fetchNews:
            return "/v1/news"
        }
    }
    
    var fullURL: String {
        return APIConfiguration.baseUrl + self.path
    }
    
    var parameters: [String: String] {
        switch self {
        case .fetchNews(let accessKey, let sources, let categories, let countries, let languages, let keywords, let date, let sort, let limit, let offset):
            var params: [String: String] = ["access_key": accessKey]
            if let sources = sources, !sources.isEmpty { params["sources"] = sources }
            if let categories = categories, !categories.isEmpty { params["categories"] = categories }
            if let countries = countries, !countries.isEmpty { params["countries"] = countries }
            if let languages = languages, !languages.isEmpty { params["languages"] = languages }
            if let keywords = keywords, !keywords.isEmpty { params["keywords"] = keywords }
            if let date = date, !date.isEmpty { params["date"] = date }
            if let sort = sort, !sort.isEmpty { params["sort"] = sort }
            if let limit = limit { params["limit"] = String(limit) }
            if let offset = offset { params["offset"] = String(offset) }
            return params
        }
    }
}
