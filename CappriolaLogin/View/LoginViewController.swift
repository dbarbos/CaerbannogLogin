//
//  LoginViewController.swift
//  CappriolaLogin
//
//  Created by Gabriel Oliveira Barbosa on 28/11/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import UIKit

public class LoginViewController: UIViewController {
    
    public var nextViewController: UIViewController?

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginButton() {
        
        if self.goToNextView() {
            present(nextViewController!, animated: true, completion: nil)
        }
        
    }
    
    public func goToNextView() -> Bool {
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

extension LoginViewController {
    public convenience init(whereNextViewControllerIs viewController: UIViewController) {
        self.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        nextViewController = viewController
    }
}
