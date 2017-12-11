//
//  DemoUITests.swift
//  DemoUITests
//
//  Created by Diler Barbosa on 01/12/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import XCTest
@testable import Demo



class DemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test001IfLoginViewIsLoadedAndDismissedIfNextButtonIsPressed() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCUIApplication().launch()
        XCTAssertTrue(XCUIApplication().otherElements["LoginViewController"].exists)
        
    }
    
    func test002UserTextFieldValidation() {
        XCUIApplication().textFields["UserIdTextField"].tap()
        XCUIApplication().textFields["UserIdTextField"].typeText("dilerBarbosa")
        
        XCUIApplication().buttons["LogInButton"].tap()
        
        XCTAssertTrue(XCUIApplication().alerts.element.staticTexts["Your password is missing"].exists)
        
        XCUIApplication().alerts.buttons["ok"].tap()
        
        XCTAssertFalse(XCUIApplication().alerts.element.staticTexts["Your password is missing"].exists)
        
        XCUIApplication().textFields["UserIdTextField"].buttons["Clear text"].tap()
        
    }
    
    func test003PasswordTextFieldValidation() {
        XCUIApplication().textFields["PasswordTextField"].tap()
        XCUIApplication().textFields["PasswordTextField"].typeText("password")
        
        XCUIApplication().buttons["LogInButton"].tap()
        
        XCTAssertTrue(XCUIApplication().alerts.element.staticTexts["Your user ID is missing"].exists)
        
        XCUIApplication().alerts.buttons["ok"].tap()
        
        XCTAssertFalse(XCUIApplication().alerts.element.staticTexts["Your user ID is missing"].exists)
        
        XCUIApplication().textFields["PasswordTextField"].buttons["Clear text"].tap()
        
    }
    
    func test004LoginSuceed() {
        XCUIApplication().textFields["UserIdTextField"].tap()
        XCUIApplication().textFields["UserIdTextField"].typeText("dilerBarbosa")
        
        XCUIApplication().textFields["PasswordTextField"].tap()
        XCUIApplication().textFields["PasswordTextField"].typeText("password")
        
        XCUIApplication().buttons["LogInButton"].tap()
        
        XCTAssertTrue(XCUIApplication().staticTexts["Welcome"].exists)
    }
    
 
    
}
