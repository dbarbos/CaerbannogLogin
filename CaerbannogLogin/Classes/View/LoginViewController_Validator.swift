//
//  LoginViewController_FieldsValidator.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 14/03/2018.
//

import UIKit

extension LoginViewController : LoginFieldsValidator {
    
    ////////////////////////////////////
    // MARK: Field Validator Method
    ////////////////////////////////////
    
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
    
    ////////////////////////////////////
    // MARK: Token Validator Method
    ////////////////////////////////////
    
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
}
