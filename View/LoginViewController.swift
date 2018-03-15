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
    
    ////////////////////////////////////
    // MARK: Configs Variable
    ////////////////////////////////////
    
    public var layout:Layout?
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
        applyLayout()
        
        
        
        //hideKeyboardWhenTappedAround()
        //_ = hasToken()
        
    }
    
    public func showController() {
        if let app = UIApplication.shared.delegate, let window = app.window {
            window?.rootViewController = self
            window?.makeKeyAndVisible()
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
    
    public func createOrUpdateKeyChainAccount(_ value: String) {
        do {
            let tokenItem = KeychainTokenItem(service: KeychainConfiguration.serviceName, account: Constants.appAccountName, accessGroup: KeychainConfiguration.accessGroup)
            try tokenItem.saveToken(value)
        }
        catch {
            fatalError("Error updating keychain - \(error)")
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

