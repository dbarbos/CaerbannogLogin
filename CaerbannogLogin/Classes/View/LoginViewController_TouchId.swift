//
//  LoginViewController.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 29/03/2018.
//

import UIKit
import LocalAuthentication

extension LoginViewController {

    public func validadeBiometry(completion: @escaping (_ result: (Bool,Error?)) -> Void) {
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: messageToShowWithBiometry,
            reply: {(success, error) -> Void in
                if( success ) {
                    
                    completion((true,nil))
                    
                }else {
                    if let error = error {
                        completion((false,error))
                    }
                    completion((false,nil))
                }
                
        })
    }
    
    func testLogoutUserIfBiometryFails(errorCode:Int) -> Bool {
        var bool = false
        switch errorCode {
        case LAError.authenticationFailed.rawValue:
            bool = true
        case LAError.appCancel.rawValue:
            bool = true
        case LAError.passcodeNotSet.rawValue:
            bool = true
        case LAError.biometryLockout.rawValue:
            bool = true
        case LAError.biometryNotAvailable.rawValue:
            bool = true
        case LAError.biometryNotEnrolled.rawValue:
            bool = true
        case LAError.userCancel.rawValue:
            bool = true
        case LAError.userFallback.rawValue:
            bool = true
        default:
            bool = false
        }
        
        return bool
    }
    
    func errorMessageForLAErrorCode( errorCode:Int ) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = LoginStrings.appCancel
            
        case LAError.authenticationFailed.rawValue:
            message = LoginStrings.authenticationFailed
            
        case LAError.invalidContext.rawValue:
            message = LoginStrings.invalidadContext
            
        case LAError.passcodeNotSet.rawValue:
            message = LoginStrings.passcodeNotSet
            
        case LAError.systemCancel.rawValue:
            message = LoginStrings.systemCancel
            
        case LAError.biometryLockout.rawValue:
            message = LoginStrings.biometricLocked
            
        case LAError.biometryNotAvailable.rawValue:
            message = LoginStrings.biometricNotAvaible
            
        case LAError.biometryNotAvailable.rawValue:
            message = LoginStrings.biometricNotEnrolled
            
        case LAError.userCancel.rawValue:
            message = LoginStrings.systemCancel
            
        case LAError.userFallback.rawValue:
            message = LoginStrings.userFallback
        default:
            message = LoginStrings.defaultLAError
            
        }
        
        return message
        
    }
    
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        showAlertWithTitle(title: "Error", message: LoginStrings.thereIsntSensor)
    }
    
    public func thereIsBiometry() -> Bool {
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            return true
        }
        else {
            return false
        }
        
    }

}
