//
//  APIGateway.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import Moya

typealias TransactionCompletionHandler = (_ result: Any?, _ error: Any?) -> Void

protocol APIGatewayProtocol {
    func getTransactions(completion: @escaping TransactionCompletionHandler)
}

class APIGateway {
    
    private let provider = MoyaProvider<APIService>()
    
}

extension APIGateway: APIGatewayProtocol {
    
    func getTransactions(completion: @escaping TransactionCompletionHandler) {
        provider.request(.getTransactions) { (result) in
            switch result {
            case .success(let response):
                do {
                    let transactions = try JSONDecoder().decode([Transaction].self, from: response.data)
                    completion(transactions, nil)
    
                } catch {
                    completion(nil, error.localizedDescription)
                }
                
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
}
