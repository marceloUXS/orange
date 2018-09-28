//
//  MainController.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
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
    }
    
    // MARK: - Private
    
    private func setup() {
        
    }
    
}


// MARK: - MainView

extension MainController: MainView {
    
    func reloadData() {
        
    }
    
}

