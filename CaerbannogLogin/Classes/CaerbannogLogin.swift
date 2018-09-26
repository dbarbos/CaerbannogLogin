//
//  CaerbannogLogin.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 20/03/2018.
//

import UIKit

public class CaerbanoggLogin {
    
    public static let shared = CaerbanoggLogin()
    private var loginController:LoginViewController!
    private var connection:ConnectionConfig!
    private var nextViewController:UIViewController!
    private var layout:Layout!
    
    public func initialize(whereNextViewControllerIs viewController: UIViewController, connection:ConnectionConfig) {
        self.loginController = LoginViewController(whereNextViewControllerIs: viewController, connection: connection)
        self.connection = connection
        self.nextViewController = viewController
    }
    
    public func showController() {
        if let _ = loginController {
            if let app = UIApplication.shared.delegate, let window = app.window {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    window?.rootViewController = self.loginController
                    window?.makeKeyAndVisible()
                }
            }
        } else {
            print("Please, use the initializer method to use showController function")
        }
    }
    
    
    
    public func setLayout(layout:Layout) {
        self.layout = layout
        if let _ = loginController {
            loginController.layout = layout
        } else {
            print("Please, use the initializer method to use setLayout function")
        }
    }
    
    public func logout(nextViewController:UIViewController) {
        self.nextViewController = nextViewController
        if let _ = loginController {
            loginController.clearKeyChain(completion: { (bool) in
                if bool {
                    loginController.dismiss(animated: false, completion: {
                        self.initialize(whereNextViewControllerIs: nextViewController, connection: self.connection)
                        if let _ = self.layout {
                            self.setLayout(layout: self.layout)
                        }
                        self.showController()
                    })
                }
            })
            
        } else {
            print("Please, use the initializer method to use logout function")
        }
    }
    
    public func getActualToken() -> String {
        if let _ = loginController {
            if loginController.hasToken() {
                if let token = loginController.getActualToken() {
                    return token
                } else {
                    return ""
                }
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    public func useTouchID(messageToShow:String) {
        if let _ = loginController {
            loginController.useTouchId = true
            loginController.messageToShowWithTouchID = messageToShow
        } else {
            
            print("Please, use the initializer method to use touchID function")
        }
    }
    
    
}
