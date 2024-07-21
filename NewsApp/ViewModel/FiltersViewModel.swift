//
//  FiltersViewModel.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import Foundation
import UIKit

class FiltersViewModel {
    var keyword = Observable(value: "")
    var category = Observable(value: "")
    var country = Observable(value: "")
    var language = Observable(value: "")
    var fromDate = Observable(value: "")
    var toDate = Observable(value: "")
    var sort = Observable(value: "")
    
    let categories = [
        "general", "business", "entertainment", "health", "science", "sports", "technology"
    ]

    let countries = [
        "Argentina": "ar", "Australia": "au", "Austria": "at", "Belgium": "be", "Brazil": "br",
        "Bulgaria": "bg", "Canada": "ca", "China": "cn", "Colombia": "co", "Czech Republic": "cz",
        "Egypt": "eg", "France": "fr", "Germany": "de", "Greece": "gr", "Hong Kong": "hk",
        "Hungary": "hu", "India": "in", "Indonesia": "id", "Ireland": "ie", "Israel": "il",
        "Italy": "it", "Japan": "jp", "Latvia": "lv", "Lithuania": "lt", "Malaysia": "my",
        "Mexico": "mx", "Morocco": "ma", "Netherlands": "nl", "New Zealand": "nz", "Nigeria": "ng",
        "Norway": "no", "Philippines": "ph", "Poland": "pl", "Portugal": "pt", "Romania": "ro",
        "Saudi Arabia": "sa", "Serbia": "rs", "Singapore": "sg", "Slovakia": "sk", "Slovenia": "si",
        "South Africa": "za", "South Korea": "kr", "Sweden": "se", "Switzerland": "ch", "Taiwan": "tw",
        "Thailand": "th", "Turkey": "tr", "UAE": "ae", "Ukraine": "ua", "United Kingdom": "gb",
        "United States": "us", "Venezuela": "ve"
    ]


    let languages = [
        "Arabic": "ar", "German": "de", "English": "en",
        "Spanish": "es", "French": "fr",
        "Italian": "it", "Dutch": "nl", "Norwegian": "no",
        "Portuguese": "pt", "Russian": "ru", "Chinese": "zh"
    ]

    let sorts = ["published_desc", "published_asc", "popularity"]
    
    func validateInputs() -> Bool {
        if !category.value.isEmpty && !categories.contains(category.value) {
            return false
        }
        if !country.value.isEmpty && !countries.keys.contains(country.value) {
            return false
        }
        if !language.value.isEmpty && !languages.keys.contains(language.value) {
            return false
        }
        if !sort.value.isEmpty && !sorts.contains(sort.value) {
            return false
        }
        
        // Date validation
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if !fromDate.value.isEmpty {
            guard dateFormatter.date(from: fromDate.value) != nil else {
                return false
            }
        }
        
        if !toDate.value.isEmpty {
            guard dateFormatter.date(from: toDate.value) != nil else {
                return false
            }
        }
        
        if !fromDate.value.isEmpty && !toDate.value.isEmpty {
            guard let fromDate = dateFormatter.date(from: fromDate.value),
                  let toDate = dateFormatter.date(from: toDate.value),
                  fromDate <= toDate else {
                return false
            }
        }
        
        return true
    }
    
}

