//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager() // Make it a singleton
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ request: Request) async throws -> T {
        guard var urlComponents = URLComponents(string: request.fullURL) else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = request.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
}
