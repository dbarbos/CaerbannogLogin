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

        // Do any additional setup after loading the view.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func goToNextView() {
        if let nextViewController = nextViewController {
            present(nextViewController, animated: true, completion: nil)
        }
        else {
            print("No UIViewController loaded.")
        }
        
    }

}

extension LoginViewController {
    public convenience init(whereNextViewControllerIs viewController: UIViewController) {
        self.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        nextViewController = viewController
    }
}
