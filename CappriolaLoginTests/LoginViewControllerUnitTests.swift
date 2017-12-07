//
//  LoginViewControllerUnitTests.swift
//  CappriolaLoginTests
//
//  Created by Diler Barbosa on 06/12/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import XCTest
@testable import CappriolaLogin

class LoginViewControllerUnitTests: XCTestCase {
    

   
    func testLoadNextViewController() {
 
        let loginViewController = LoginViewController(whereNextViewControllerIs: UIViewController())
    
        XCTAssert(loginViewController.goToNextView() == true, "Deveria retornar true, indicando que é possivel navegar para a próxima ViewController")
 
    }
    
    func testLoadNextViewControllerButFoundNil() {
        
        let loginViewController = LoginViewController(whereNextViewControllerIs: UIViewController())
        loginViewController.nextViewController = nil
        
        XCTAssert(loginViewController.goToNextView() == false, "Deveria retornar false, indicando que não é possivel navegar para a próxima ViewController")
        
    }
    
    
}
