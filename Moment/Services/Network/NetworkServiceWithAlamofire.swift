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
            case .success(let questions):
                completion(.success(questions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
