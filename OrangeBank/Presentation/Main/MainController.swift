//
//  MainController.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var presenter: PresenterBase?
    
    private var mainPresenter: MainPresenter {
        guard let viewPresenter = presenter as? MainPresenter else {
            fatalError("MainPresenter - Can't be nil!")
        }
        
        return viewPresenter
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainPresenterDefault(view: self)
        mainPresenter.viewDidLoad()
        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
    }
    
}

// MARK: - TableViewDelegate and TableViewDataSource

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainPresenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") else {
            fatalError("TransactionCell - Wrong ID or cell configuration!")
        }
        
        mainPresenter.configureItem(cell, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

// MARK: - MainView

extension MainController: MainView {
    
    func reloadData() {
        loader.stopAnimating()
        tableView.reloadData()
    }
    
}

