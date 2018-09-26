//
//  LoginViewController_Animations.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 14/03/2018.
//

import UIKit

extension LoginViewController {
    
    ////////////////////////////////////
    // MARK: Animation Methods
    ////////////////////////////////////
    
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
    
    ////////////////////////////////////
    // MARK: Present Controller Animated Method
    ////////////////////////////////////
    
    func presentNextViewAnimation() {
        
        let nextView = nextViewController?.view

        self.view.bringSubviewToFront(loginButton)
        
        UIView.animate(withDuration: 0.9, delay: 0.0, options: .curveEaseOut, animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 50.0, y: 50.0)
            
        }) { (success) in
            
            self.view.addSubview(nextView!)
            self.view.bringSubviewToFront(self.loginButton)
            
            UIView.animate(withDuration: 0.7, animations: {
                self.loginButton.alpha = 0
            }, completion: { (_) in
                self.present(self.nextViewController!, animated: false, completion: nil)
            })
        }
        
    }
}
