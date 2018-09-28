//
//  Transaction.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class Transaction {
    let id: Int?
    let date: Date?
    let amount: Double?
    let fee: Double?
    let description: String?
    
    init(id: Int?, date: Date?, amount: Double?, fee: Double?, description: String?) {
        self.id = id
        self.date = date
        self.amount = amount
        self.fee = fee
        self.description = description
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TransactionKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        self.fee = try container.decodeIfPresent(Double.self, forKey: .fee)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        
        let dateString = try container.decodeIfPresent(String.self, forKey: .date)
        let formatter = DateFormatter.iso8601Full
        self.date = formatter.date(from: dateString ?? "")
    }
    

}

extension Transaction: Codable {
    
    enum TransactionKeys: String, CodingKey {
        case id
        case date
        case amount
        case fee
        case description
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TransactionKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(amount, forKey: .amount)
        try container.encode(fee, forKey: .fee)
        try container.encode(description, forKey: .description)
    }
}
