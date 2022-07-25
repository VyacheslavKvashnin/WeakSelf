//
//  NetworkManager.swift
//  WeakSelf
//
//  Created by Вячеслав Квашнин on 25.07.2022.
//

import Foundation

enum NetworkError: String, Error {
    case badURL = "No connection to url address."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidData = "The data received from the server was invalid. Please try again."
}

class NetworkManager {
    
    func fetchData(completion: @escaping(Result<[Post], NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return }
            do {
                let type = try JSONDecoder().decode([Post].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(type))
                    print(type)
                }
            } catch {
                completion(.failure(.invalidData))
            }
            
        }.resume()
    }
}
