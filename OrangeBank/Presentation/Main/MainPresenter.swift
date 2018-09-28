//
//  MainPresenter.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

protocol MainView: class {
    func reloadData()
}

protocol MainPresenter: PresenterBase {
    var paymentGateway: APIGateway { get }
    var transactions: [Transaction]? { get }
}

class MainPresenterDefault: MainPresenter {
    
    var paymentGateway: APIGateway = APIGateway()
    
    var transactions: [Transaction]?
    
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
    
    // MARK: - Private
    
    private func loadTransactions() {
        paymentGateway.getTransactions { (result, error) in
            guard let transactions = result as? [Transaction] else {
                return
            }
            
            self.transactions = transactions
            self.view?.reloadData()
        }
    }
    
}
