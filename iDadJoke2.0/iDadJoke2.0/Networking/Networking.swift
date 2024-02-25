//
//  Networking.swift
//  iDadJoke2.0
//
//  Created by Yohannes Haile on 2/25/24.
//

import Foundation

enum APIError: Error{
    case decodingProblem
    case responseProblem
}
class Networking{
    
    static let shared = Networking()
    
    let baseURL = "https://dad-jokes.p.rapidapi.com/random/joke"
    let headers = [
        "X-RapidAPI-Key": "",
        "X-RapidAPI-Host": ""
    ]
    
    func getDadJoke(completion: @escaping(Result<DadJokeResponse, APIError>)-> Void){
        
        let url = URL(string: baseURL)
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let decoder = JSONDecoder()
                let feed = try decoder.decode(DadJokeResponse.self, from: data)
                completion(.success(feed))
            } catch{
                completion(.failure(.decodingProblem))
            }
        }
        task.resume()
    }
}


