//
//  NetworkServiceWithAlamofire.swift
//  Moment
//
//  Created by Gleb on 23.10.2023.
//

import Foundation
import Alamofire

protocol NetworkLayerProtocol {
    func fetchData(url: URL, completion: @escaping (Result<[QuestionModel], Error>) -> Void)
}


class NetworkServiceWithAlamofire: NetworkLayerProtocol {
    
    static let shared = NetworkServiceWithAlamofire()
    private init () {}
    
    
    
    func fetchData(url: URL, completion: @escaping (Result<[QuestionModel], Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [QuestionModel].self) { response in
            switch response.result {
            case .success(let questions) :
                if let jsonArray = questions as? [[String: Any]] {
                    do {
                        let jsonData = try
                        JSONSerialization.data(withJSONObject: jsonArray)
                        let questions = try
                        JSONDecoder().decode([QuestionModel].self, from: jsonData)
                        completion(.success(questions))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    let error = NSError(domain:  "Invalid response format", code: 0)
                    completion(.failure(error))
                }
                completion(.success(questions))
                print(questions)
            case .failure(let error) :
                completion(.failure(error))
            }
        }
        
    }
    
}
