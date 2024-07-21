//
//  Observable.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    private var listener: ((T) -> Void)?
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
    }
}
