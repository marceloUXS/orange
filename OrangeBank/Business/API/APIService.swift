//
//  APIService.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import Moya

enum APIService {
    case getTransactions
}

extension APIService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.myjson.com/bins/1a30k8")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}
