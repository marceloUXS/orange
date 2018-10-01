//
//  APIGatewayTests.swift
//  OrangeBankTests
//
//  Created by Marcelo on 30/9/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import XCTest
@testable import OrangeBank

class APIGatewayTests: XCTestCase {
    private var transactionGateway: APIGateway!
    
    func testTransactionRetrieved() {
        givenATransactionRequest()
        whenTryToRetrieveTransactions { [unowned self] transactions, gatewayExpectation in
            self.thenTheTransactionsListIsRetrieved(transactions: transactions,
                                                expectation: gatewayExpectation)
        }
        thenTheGatewayFinishedToTryToRetrieve()
    }
    
    private func givenATransactionRequest() {
        transactionGateway = APIGateway()
    }
    
    func whenTryToRetrieveTransactions(finish: @escaping ([Transaction]?, XCTestExpectation) -> Void) {
        let gatewayExpectation = expectation(description: "GatewayExpectation")
        transactionGateway.getTransactions { (transactions, error) in
            guard let transactions = transactions as? [Transaction] else {
                finish(nil, gatewayExpectation)
                return
            }
            
            finish(transactions, gatewayExpectation)
        }
    }
    
    private func thenTheTransactionsListIsRetrieved(transactions: [Transaction]?, expectation: XCTestExpectation) {
        XCTAssertNotNil(transactions)
        XCTAssertTrue(transactions!.count > 0)
        expectation.fulfill()
    }
    
    private func thenTheGatewayFinishedToTryToRetrieve() {
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Repository finish() not called: \(error)")
            }
        }
    }
    
}
