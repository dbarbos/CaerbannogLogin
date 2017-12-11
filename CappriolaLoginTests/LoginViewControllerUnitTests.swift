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
    
    var loginViewController : LoginViewController!
    var userIdTextField : UITextField!
    var passwordTextField : UITextField!
    
    override func setUp() {
        super.setUp()
        loginViewController = LoginViewController(whereNextViewControllerIs: UIViewController())
    }
    
    override func tearDown() {
        loginViewController = nil
        super.tearDown()
    }
    
    func testLoadNextViewController() {

        XCTAssert(loginViewController.canPresentNextView() == true, "Deveria retornar true, indicando que é possivel navegar para a próxima ViewController.")
 
    }
    
    func testLoadNextViewControllerButFoundNil() {

        loginViewController.nextViewController = nil
        XCTAssert(loginViewController.canPresentNextView() == false, "Deveria retornar false, indicando que não é possivel navegar para a próxima ViewController.")
        
    }
    
    func testLoginFieldValidationWithEmptyFields() {
        userIdTextField = UITextField()
        passwordTextField = UITextField()
        
        XCTAssert(loginViewController.loginFieldsAreValid(userIdField: userIdTextField, passwordField: passwordTextField) == false, "Deveria retornar false indicando que os campos estão sem dados.")
  
    }
    
    func testLoginFieldValidationWithAllFieldsPopulated() {
        userIdTextField = UITextField()
        passwordTextField = UITextField()
        
        userIdTextField.text = "Diler"
        passwordTextField.text = "password"
        
        XCTAssert(loginViewController.loginFieldsAreValid(userIdField: userIdTextField, passwordField: passwordTextField) == true, "Deveria retornar true indicando que os campos estão preenchidos.")
        
    }
    
    func testLoginFieldValidationWithEmptyPasswordField() {
        userIdTextField = UITextField()
        passwordTextField = UITextField()
        
        userIdTextField.text = "Diler"
        
        XCTAssert(loginViewController.loginFieldsAreValid(userIdField: userIdTextField, passwordField: passwordTextField) == false, "Deveria retornar false indicando que o campo de password não tem valor.")
        
        passwordTextField.text = ""
        
        XCTAssert(loginViewController.loginFieldsAreValid(userIdField: userIdTextField, passwordField: passwordTextField) == false, "Deveria retornar false indicando que o campo de password está vazio.")
        
    }
    
    func testLoginFieldValidationWithEmptyUserIdField() {
        userIdTextField = UITextField()
        passwordTextField = UITextField()
        
        passwordTextField.text = "password"
        
        XCTAssert(loginViewController.loginFieldsAreValid(userIdField: userIdTextField, passwordField: passwordTextField) == false, "Deveria retornar false indicando que o campo de usuario não tem valor.")
        
        userIdTextField.text = ""
        
        XCTAssert(loginViewController.loginFieldsAreValid(userIdField: userIdTextField, passwordField: passwordTextField) == false, "Deveria retornar false indicando que o campo de usuario está vazio.")
        
    }
    
    
}
