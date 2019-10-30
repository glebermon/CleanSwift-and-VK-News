//
//  NetworkService.swift
//  VKNews
//
//  Created by Глеб on 12.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import Foundation

/*https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.102*/

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    private let authServise : AuthService
    
    init(authService : AuthService = AppDelegate.shared().authService) {
        self.authServise = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authServise.token else { fatalError("Something go wrong") }
        
//        let params = ["filters" : "post,photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = self.url(from: path, params: allParams)
        print(url)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        
        
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, respose, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        
    }
    
    private func url(from path: String, params: [String : String]) -> URL {
        
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
        
    }
    
    /* Для теста, чтобы видеть, в каком формате у меня URL для запроса данных в JSON */
    
    /*
    func getFeed() {
        
        guard let token = authServise.token else { return }
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "filters", value: "post,photo"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.102"),
        ]
        print(urlComponents.url)
    }
    */
    
}
