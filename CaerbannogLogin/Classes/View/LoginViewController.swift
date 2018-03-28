//
//  LoginViewController.swift
//  CappriolaLogin
//
//  Created by Gabriel Oliveira Barbosa on 28/11/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol Navigatable {
    func canPresentNextView() -> Bool
}

protocol LoginFieldsValidator {
    func loginFieldsAreValid(userIdField: UITextField, passwordField: UITextField) -> Bool
}

public struct ImagesHelper {
    private static var podsBundle: Bundle {
        return Bundle(for: LoginViewController.self)
    }
    
    public static func imageFor(name imageName: String) -> UIImage {
        return UIImage.init(named: imageName, in: podsBundle, compatibleWith: nil)!
    }
    
    
}

public class LoginViewController: UIViewController {
    
    ////////////////////////////////////
    // MARK: IBOutlet
    ////////////////////////////////////
    
    @IBOutlet public weak var backgroundImage : UIImageView!
    @IBOutlet public weak var loginButton : UIButton!
    @IBOutlet public weak var activityView : UIActivityIndicatorView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var lineLogin: UILabel!
    @IBOutlet weak var linePassword: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    @IBOutlet weak var userIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    ////////////////////////////////////
    // MARK: Other Variables
    ////////////////////////////////////
    
    var tokenItem = [KeychainTokenItem]()
    let cappriolaRequestHelper = CappriolaRequestHelper()
    public var nextViewController: UIViewController?
    public var tokenField: String = "access_token"
    internal var isTypingLogin : Bool = false
    internal var isLoading : Bool = false
    internal var regularLoginButton : UIButton = UIButton()
    
    let authenticationContext = LAContext()
    
    ////////////////////////////////////
    // MARK: Configs Variable
    ////////////////////////////////////
    
    public var layout:Layout?
    public var useTouchId = false
    public var messageToShowWithTouchID = ""
    var connectionConstant:ConnectionConfig!
    
    ////////////////////////////////////
    // MARK: View Controller Methods
    ////////////////////////////////////
    
    public convenience init(whereNextViewControllerIs viewController: UIViewController, connection:ConnectionConfig) {
        self.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        connectionConstant = connection
        
        nextViewController = viewController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        cappriolaRequestHelper.delegate = self
        userIdField.delegate = self
        passwordField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        regularLoginButton = loginButton
        
        let defaultBackgroundImage = ImagesHelper.imageFor(name: "defaultBackgroundImage.png")
        backgroundImage.image = defaultBackgroundImage
        
        let logoImg = ImagesHelper.imageFor(name: "logo.png")
        logoImage.image = logoImg
        
        let pswImg = ImagesHelper.imageFor(name: "password.png")
        passwordIcon.image = pswImg
        
        let userImg = ImagesHelper.imageFor(name: "user.png")
        userIcon.image = userImg
        
        applyLayout()
        
        
        //hideKeyboardWhenTappedAround()
        
        if hasToken() {
            
            if useTouchId {
                
                if thereIsTouchId() {
                    
                    validadeTouchId(completion: { (result) in
                        let resultBool = result.0
                        let error = result.1
                        
                        if resultBool {
                            self.segueToNextView()
                        } else {
                            var message = ""
                            if let errorLA = error as? LAError {
                                if self.testLogoutUserIfTouchIdFails(errorCode: errorLA.code.rawValue) {
                                    self.clearKeyChain(completion: { (bool) in

                                    })
                                }
                                message = self.errorMessageForLAErrorCode(errorCode: errorLA.code.rawValue)
                            } else {
                                message = "Unknown error: Can't validade error message"
                            }
                            self.showAlertWithTitle(title: "Error in validation", message: message)
                        }
                        
                    })
                } else {
                    self.showAlertWithTitle(title: "Error in validation", message: "There isn't touchId in this device")
                }
            } else {
                self.segueToNextView()
            }
            
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
    }
    
    public func segueToNextView() {
        DispatchQueue.main.async {
        
        
        if let app = UIApplication.shared.delegate, let window = app.window {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                window?.rootViewController?.present(self.nextViewController!, animated: false, completion: {
                    
                })
            }
        }
        }
    }
    
    
    public func validadeTouchId(completion: @escaping (_ result: (Bool,Error?)) -> Void) {
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: messageToShowWithTouchID,
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
    
    func testLogoutUserIfTouchIdFails(errorCode:Int) -> Bool {
        var bool = false
        switch errorCode {
        case LAError.authenticationFailed.rawValue:
            bool = true
        case LAError.appCancel.rawValue:
            bool = true
        case LAError.passcodeNotSet.rawValue:
            bool = true
        case LAError.touchIDLockout.rawValue:
            bool = true
        case LAError.touchIDNotAvailable.rawValue:
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
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials, you need to login again."
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }
    
    
    public func thereIsTouchId() -> Bool {
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            return true
        }
        else {
            return false
        }
        
    }
    
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
    }
    
    func showAlertWithTitle( title:String, message:String ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    ////////////////////////////////////
    // MARK: Keyboard Control
    ////////////////////////////////////
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ////////////////////////////////////
    // MARK: IBActions
    ////////////////////////////////////
    
    @IBAction func loginButtonPress() {
        if self.loginFieldsAreValid(userIdField: userIdField,passwordField: passwordField) && self.canPresentNextView() {
            userIdField.resignFirstResponder()
            passwordField.resignFirstResponder()
            if CappriolaReachability.isConnectedToNetwork() {
                animateLoginbutton()
                if hasToken() {
                    
                    //validateToken()
                }else{
                    if let 👤 = userIdField.text {
                        if let 🔐 = passwordField.text {
                            self.login(username: 👤, password: 🔐)
                        }
                    }
                }
            } else{
                self.present(Alerts().noNetworkDetected(), animated: true, completion: nil)
            }
        }
    }
    
    ////////////////////////////////////
    // MARK: KeyChain Methods
    ////////////////////////////////////
    
    public func createOrUpdateKeyChainAccount(_ value: String, completion: (_ token: String?) -> Void) {
        do {
            let tokenItem = KeychainTokenItem(service: KeychainConfiguration.serviceName, account: Constants.appAccountName, accessGroup: KeychainConfiguration.accessGroup)
            try tokenItem.saveToken(value)
            completion(value)
        }
        catch {
            completion(nil)
            fatalError("Error updating keychain - \(error)")
        }
    }
    
    public func getActualToken() -> String {
        do {
            let tokenItem = KeychainTokenItem(service: KeychainConfiguration.serviceName, account: Constants.appAccountName, accessGroup: KeychainConfiguration.accessGroup)
            let token = try tokenItem.readToken()
            return token
        }
        catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    
    public func clearKeyChain(completion: (_ result: Bool) -> Void) {
        do {
            let tokenItem = KeychainTokenItem(service: KeychainConfiguration.serviceName, account: Constants.appAccountName, accessGroup: KeychainConfiguration.accessGroup)
            try tokenItem.deleteItem()
            completion(true)
        }
        catch {
            completion(false)
        }
    }
    
    
    
}

////////////////////////////////////
// MARK: Navigatable Extension
////////////////////////////////////

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

////////////////////////////////////
// MARK: TextField Extension
////////////////////////////////////

extension LoginViewController : UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        isTypingLogin = true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        isTypingLogin = false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userIdField {
            self.passwordField.becomeFirstResponder()
        }else{
            self.passwordField.resignFirstResponder()
        }
        return true
    }
    
}


////////////////////////////////////
// MARK: ViewController Extension
////////////////////////////////////

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

