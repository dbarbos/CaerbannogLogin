//
//  LoginViewController.swift
//  CappriolaLogin
//
//  Created by Gabriel Oliveira Barbosa on 28/11/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import UIKit

protocol Navigatable {
    func canPresentNextView() -> Bool
}

protocol LoginFieldsValidator {
    func loginFieldsAreValid(userIdField: UITextField, passwordField: UITextField) -> Bool
}

public class LoginViewController: UIViewController {
    
    public var nextViewController: UIViewController?
    
    var tokenItem = [KeychainTokenItem]()
    
    @IBOutlet var userIdField: UITextField!
    @IBOutlet var passwordField: UITextField!

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = hasToken()
        
    }
    
    public func hasToken() -> Bool {
        do {
            tokenItem = try KeychainTokenItem.tokenItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
        }
        catch {
            fatalError("Error fetching password items - \(error)")
        }
        
        if tokenItem.contains(where: { $0.account == Constants.appAccountName }) {
            print("Possui token")
            return true
        }
        
        return false
    }
    

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginButton() {
        
        if self.loginFieldsAreValid(userIdField: userIdField,passwordField: passwordField) && self.canPresentNextView() {
            
            createOrUpdateKeyChainAccount(Constants.appAccountName)
            
            present(nextViewController!, animated: true, completion: nil)
        }
        
    }
    
    public func createOrUpdateKeyChainAccount(_ accountName: String) {
        do {
            let tokenItem = KeychainTokenItem(service: KeychainConfiguration.serviceName, account: accountName, accessGroup: KeychainConfiguration.accessGroup)
            try tokenItem.saveToken("ABCDEFGHIJKL")
        }
        catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    

}

extension LoginViewController {
    public convenience init(whereNextViewControllerIs viewController: UIViewController) {
        self.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        nextViewController = viewController
    }
}

extension LoginViewController : Navigatable {
    
    public func canPresentNextView() -> Bool {
        if let _ = nextViewController {
            print("Next UIViewController can be loaded.")
            return true
        }
        else {
            print("No UIViewController loaded.")
        }
        return false
    }
}

extension LoginViewController : LoginFieldsValidator {
    
    public func loginFieldsAreValid(userIdField: UITextField, passwordField: UITextField) -> Bool {
        
        guard let newAccountName = userIdField.text else {
            self.present(Alerts().userIdFieldMissing(), animated: true, completion: nil)
            return false
        }
        
        guard !newAccountName.isEmpty else {
            self.present(Alerts().userIdFieldMissing(), animated: true, completion: nil)
            return false
        }
        
        guard let newPassword = passwordField.text else {
            self.present(Alerts().passwordFieldMissing(), animated: true, completion: nil)
            return false
        }
        
        guard !newPassword.isEmpty else {
            self.present(Alerts().passwordFieldMissing(), animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
}
