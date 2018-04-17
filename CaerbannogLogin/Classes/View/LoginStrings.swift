//
//  LoginStrings.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 29/03/2018.
//

import UIKit

public class LoginStrings {
    static var appCancel = "Authentication was cancelled by application"
    static var authenticationFailed = "The user failed to provide valid credentials, you need to login again."
    static var invalidadContext = "The context is invalid"
    static var passcodeNotSet = "Passcode is not set on the device"
    static var systemCancel = "Authentication was cancelled by the system"
    static var touchIdLocked = "Too many failed attempts."
    static var touchIdNotAvaibled = "TouchID is not available on the device"
    static var userFallback = "The user chose to use the fallback"
    static var defaultLAError = "Did not find error code on LAError object"
    static var userCancel = "User canceled touch Id"
    static var thereIsntSensor = "This device does not have TouchID configured."
    static var unknownError = "Unknown error: Can't validade error message"
    static var fatalErrorView = "Fatal error in login, we can't find the next view in flow"
}
