//
//  TransactionCell.swift
//  OrangeBank
//
//  Created by Marcelo on 28/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

protocol TransactionCellType: class {
    var amount: Double? { get set }
    var date: Date? { get set }
    var transactionDescription: String? { get set }
    var isIncome: Bool { get set }
}

class TransactionCell: UITableViewCell, TransactionCellType {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var amount: Double? = nil {
        didSet {
            amountLabel.text = amount?.description
        }
    }
    
    var date: Date? = nil {
        didSet {
            dateLabel.text = date?.toString(style: .long)
        }
    }
    
    var transactionDescription: String? = nil {
        didSet {
            descriptionLabel.text = transactionDescription
        }
    }
    
    var isIncome: Bool = true {
        didSet {
            
            if isIncome {
                amountLabel.textColor = UIColor.green
            } else {
                amountLabel.textColor = UIColor.red
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
