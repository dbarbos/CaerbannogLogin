//
//  CappriolaLoginTests.swift
//  CappriolaLoginTests
//
//  Created by Diler Barbosa on 28/11/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import XCTest
@testable import CappriolaLogin

class CappriolaLoginTests: XCTestCase {
    
    func testDeSelecaoDeMetodoGET() {
        let login = Login(method: .GET)
        
        XCTAssertEqual(login.method, .GET)
        XCTAssertEqual(login.method.rawValue, "get")
    }
    
    func testDeSelecaoDeMetodoPOST() {
        let login = Login(method: .POST)
        
        XCTAssertEqual(login.method, .POST)
        XCTAssertEqual(login.method.rawValue, "post")
    }

}
