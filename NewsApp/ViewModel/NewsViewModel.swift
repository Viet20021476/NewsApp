//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import Foundation

struct NewsFilters {
    var keyword: String
    var category: String
    var country: String
    var language: String
    var fromDate: String
    var toDate: String
    var sort: String
}

class NewsViewModel {
    var news: Observable<[News]> = Observable(value: [])
    var isLoading: Observable<Bool> = Observable(value: false)
    private let networkManager: NetworkManager = NetworkManager.shared
    
    private var currentOffset: Int = 0
    private let limit: Int = 25
    private var totalItems: Int = 0
    
    func fetchNews(sources: String? = nil, categories: String? = nil, countries: String? = nil, languages: String? = nil, keywords: String? = nil, date: String? = nil, sort: String? = nil, isPagination: Bool = false) async throws {
        if !isPagination {
            self.currentOffset = 0
            self.totalItems = 0
        }
        
        guard currentOffset < totalItems || totalItems == 0 else {
            return
        }
        
        isLoading.value = true
        
        do {
            let request = Request.fetchNews(accessKey: APIConfiguration.accessKey, sources: sources, categories: categories, countries: countries, languages: languages, keywords: keywords, date: date, sort: sort, limit: limit, offset: currentOffset)
            
            let response: NewsResponse = try await networkManager.request(request)
            
            if isPagination {
                self.news.value.append(contentsOf: response.data)
            } else {
                self.news.value = response.data
                self.totalItems = response.pagination.total
            }
            
            self.currentOffset += limit
            isLoading.value = false
        } catch {
            isLoading.value = false
            throw error
        }
    }
    
    func createDateParams(fromDate: String, toDate: String) -> String {
        if !fromDate.isEmpty && toDate.isEmpty { return fromDate }
        if fromDate.isEmpty && !toDate.isEmpty { return toDate }
        if !fromDate.isEmpty && !toDate.isEmpty { return "\(fromDate),\(toDate)"}
        
        return ""
    }
}
