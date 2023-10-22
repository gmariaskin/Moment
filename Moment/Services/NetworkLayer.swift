//
//  NetworkLayer.swift
//  Moment
//
//  Created by Gleb on 22.10.2023.
//

import UIKit
import Alamofire

protocol NetworkLayerProtocol {
    func fetchDate(url: URL, completion: @escaping (Result<[Employee], Error>) -> Void)
}

class NetworkLayer: NetworkLayerProtocol {
    
    static let shared = NetworkLayer()
    private init() {}
    
    func fetchDate(url: URL, completion: @escaping (Result<[Employee], Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [Employee].self) { response in
            switch response.result {
            case .success(let employees):
                if let jsonArray = employees as? [[String: Any]] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonArray)
                        let employees = try JSONDecoder().decode([Employee].self, from: jsonData)
                        completion(.success(employees))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "Invalid response format", code: 0)
                    completion(.failure(error))
                }
                completion(.success(employees))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
