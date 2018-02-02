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
    
    var tokenItem = [KeychainTokenItem]()
    
    let cappriolaRequestHelper = CappriolaRequestHelper()
    
    @IBOutlet public weak var backgroundImage : UIImageView!
    @IBOutlet public weak var loginButton : UIButton!
    @IBOutlet public weak var activityView : UIActivityIndicatorView!
    
    @IBOutlet weak var userIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    public var nextViewController: UIViewController?
    public var ratURL : String?
    public var vatURL : String?
    public var tokenField: String = "access_token"
    
    internal var isTypingLogin : Bool = false
    internal var isLoading : Bool = false
    internal var regularLoginButton : UIButton = UIButton()
    
    public convenience init(whereNextViewControllerIs viewController: UIViewController, requestAccessTokenURL ratURL: String, validateAccessTokenURL vatURL: String, nibName: String, bundle: Bundle) {
        
        //self.init()
        //self.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        self.init(nibName: nibName, bundle: bundle)
        nextViewController = viewController
        
        
        
        self.ratURL = ratURL
        self.vatURL = vatURL
    
   
    }
    
    public convenience init(whereNextViewControllerIs viewController: UIViewController, requestAccessTokenURL ratURL: String, validateAccessTokenURL vatURL: String) {
        
        self.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        
       
        nextViewController = viewController
        
        self.ratURL = ratURL
        self.vatURL = vatURL
        

    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        cappriolaRequestHelper.delegate = self
        
        userIdField.delegate = self
        passwordField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        
        regularLoginButton = loginButton
        
        //_ = hasToken()
        
    }
    
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
    
    func animateLoginButtonToLoadingState() {
        isLoading = true
        
        self.loginButton.setTitle("", for: .normal)
        
        if let _ = self.activityView {
            self.activityView.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.05, options: .curveEaseInOut, animations: {
                self.loginButton.frame = CGRect(x: self.view.frame.width/2 - self.loginButton.frame.height/2, y: self.loginButton.frame.minY, width: self.loginButton.frame.height, height: self.loginButton.frame.height)
                
            }) { (sucess) in
                
            }
        })
    }
    
    func animateLoginButtonToNormalState() {
        isLoading = false
        
        self.loginButton.setTitle("Log In", for: .normal)
        
        if let _ = self.activityView {
            self.activityView.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.05, options: .curveEaseInOut, animations: {
                self.loginButton.frame = self.regularLoginButton.frame
                
            }) { (sucess) in
                
            }
        })
        
        
    }
    
    func animateLoginbutton() {
        
        if isLoading {
            animateLoginButtonToNormalState()
        }else{
            animateLoginButtonToLoadingState()
        }

    }
    
    
    @IBAction func loginButtonPress() {
        
       
        if self.loginFieldsAreValid(userIdField: userIdField,passwordField: passwordField) && self.canPresentNextView() {
            
            
            
            if CappriolaReachability.isConnectedToNetwork() {
                
                animateLoginbutton()
                
                if !hasToken() {
                    //validateToken()
                }else{
                    if let 👤 = userIdField.text {
                        if let 🔐 = passwordField.text {
                            cappriolaRequestHelper.login(header: ["Content-Type":"application/json"], body: ["grant_type":"password","client_id":"2","client_secret":"WTOBM7ILvYzAIAuomMIJKciF0w9F8BLLsoQRJ8rd","username":👤,"password":🔐], method: "POST", endPoint: "http://localhost/eventos-server/public/oauth/token")
                        }
                    }
 
                }
                
            }else{
                self.present(Alerts().noNetworkDetected(), animated: true, completion: nil)
            }
            
            
    
        }
        
    }
    
    
    func presentNextViewAnimation() {
        
        let nextView = nextViewController?.view
        
        self.view.bringSubview(toFront: loginButton)
        
        UIView.animate(withDuration: 0.9, delay: 0.0, options: .curveEaseOut, animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 50.0, y: 50.0)
            
        }) { (success) in
            
            self.view.addSubview(nextView!)
            self.view.bringSubview(toFront: self.loginButton)
            
            UIView.animate(withDuration: 0.7, animations: {
                self.loginButton.alpha = 0
            }, completion: { (_) in
                self.present(self.nextViewController!, animated: false, completion: nil)
            })
        }

    }
    
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

extension LoginViewController : CappriolaRequestHelperDelegate {
    func requestSuccess(message: String, requestType: RequestType, data: Data) {
        let myDictionary = CappriolaHTTPRequest.getJSONfrom(data: data)
        
        if let myToken = myDictionary[tokenField] as? String {
            createOrUpdateKeyChainAccount(myToken)
            presentNextViewAnimation()
        }
        
    }
    
    func requestFail(message: String, requestType: RequestType) {
        
        self.animateLoginbutton()
        
        self.present(Alerts().accessDenied(), animated: true, completion: nil)
        
    }
}

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

