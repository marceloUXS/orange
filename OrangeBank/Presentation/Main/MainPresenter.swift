//
//  MainPresenter.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

protocol MainView: class {
    
}

protocol MainPresenter: PresenterBase {
    
}

class MainPresenterDefault: MainPresenter {
    
    // MARK: - Initialization
    
    init(){
    }
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        print("SUPER FLAG")
    }
    
    func viewDidApper() {
        
    }
    
}
