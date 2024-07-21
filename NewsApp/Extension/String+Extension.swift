//
//  String+Extension.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 21/7/24.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }

    func convertToFormattedString() -> String? {
        guard let date = self.convertToDate() else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
