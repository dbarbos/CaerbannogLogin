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
        case Int(kLAErrorAuthenticationFailed):
            bool = true
        case Int(kLAErrorAppCancel):
            bool = true
        case Int(kLAErrorPasscodeNotSet):
            bool = true
        case Int(kLAErrorBiometryLockout):
            bool = true
        case Int(kLAErrorBiometryNotAvailable):
            bool = true
        case Int(kLAErrorBiometryNotEnrolled):
            bool = true
        case Int(kLAErrorUserCancel):
            bool = true
        case Int(kLAErrorUserFallback):
            bool = true
        default:
            bool = false
        }
        
        return bool
    }
    
    func errorMessageForLAErrorCode( errorCode:Int ) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case Int(kLAErrorAppCancel):
            message = LoginStrings.appCancel
            
        case Int(kLAErrorAuthenticationFailed):
            message = LoginStrings.authenticationFailed
            
        case Int(kLAErrorInvalidContext):
            message = LoginStrings.invalidadContext
            
        case Int(kLAErrorPasscodeNotSet):
            message = LoginStrings.passcodeNotSet
            
            
        case Int(kLAErrorBiometryLockout):
            message = LoginStrings.biometricLocked
            
        case Int(kLAErrorBiometryNotAvailable):
            message = LoginStrings.biometricNotAvaible
            
        case Int(kLAErrorBiometryNotEnrolled):
            message = LoginStrings.biometricNotEnrolled
            
        case Int(kLAErrorUserCancel):
            message = LoginStrings.systemCancel
            
        case Int(kLAErrorUserFallback):
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
