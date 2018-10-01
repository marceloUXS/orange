//
//  MainPresenter.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

protocol MainView: class {
    func reloadData()
    func setLastTransaction(amount: Double?)
}

protocol MainPresenter: PresenterBase {
    var paymentGateway: APIGateway { get }
    var transactions: [Transaction]? { get }
    var lastTransaction: Transaction? { get }
    
    func numberOfRows() -> Int
    func configureItem(_ cell: UITableViewCell, at indexPath: IndexPath)
}

class MainPresenterDefault: MainPresenter {
    
    var paymentGateway: APIGateway = APIGateway()
    
    var transactions: [Transaction]?
    
    var lastTransaction: Transaction?
    
    private weak var view: MainView?
    
    // MARK: - Initialization
    
    init(view: MainView?){
        self.view = view
    }
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        loadTransactions()
    }
    
    func viewDidApper() {
        
    }
    
    // MARK: - MainPresenter
    
    func numberOfRows() -> Int {
        return transactions?.count ?? 0
    }
    
    func configureItem(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let transactions = transactions else {
            return
        }
        
        let item = transactions[indexPath.row]
        
        if let cell = cell as? TransactionCellType {
            let amount = getTotalAmount(amount: item.amount, fee: item.fee)
            
            cell.amount = amount
            cell.date = item.date
            cell.transactionDescription = getDescription(description: item.description)
            cell.isIncome = isIncome(amount: amount)
        }
        
    }
    
    // MARK: - Private
    
    private func getDescription(description: String?) -> String? {
        guard let description = description, description != "" else {
            return "Transacción"
        }
        
        return description
    }
    
    private func getTotalAmount(amount: Double?, fee: Double?) -> Double? {
        guard let amount = amount else {
            return nil
        }
        
        if let fee = fee {
            return amount + fee
        }
        
        return amount
    }
    
    private func isIncome(amount: Double?) -> Bool {
        guard let amount = amount else {
            return true
        }
        
        if amount < 0.0 {
            return false
        }
        
        return true
    }
    
    private func loadTransactions() {
        paymentGateway.getTransactions { (result, error) in
            guard let transactions = result as? [Transaction] else {
                return
            }

            self.sortTransactions(transactions)
        }
    }
    
    private func sortTransactions(_ transactions: [Transaction]) {
        var transactions = transactions

        transactions = transactions.filter { $0.date != nil }
 
        transactions = transactions.sorted(by: {
            $0.date?.compare($1.date ?? Date()) == .orderedDescending
        })
        
        lastTransaction = transactions.first
        transactions.removeFirst()
        
        self.transactions = transactions
        self.view?.setLastTransaction(amount: getTotalAmount(amount: lastTransaction?.amount, fee: lastTransaction?.fee))
        self.view?.reloadData()
    }
    
}
