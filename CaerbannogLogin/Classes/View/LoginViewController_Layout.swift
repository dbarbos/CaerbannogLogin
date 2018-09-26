//
//  LoginViewController_Layout.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 14/03/2018.
//

import UIKit

extension LoginViewController {
    
    ////////////////////////////////////
    // MARK: Layout Customization Methods
    ////////////////////////////////////
    
    func applyLayout() {
        if let layout = layout {
            
            switch layout {
            case .Simple(let layout):
                
                if let d = layout.backgroundImage {
                    backgroundImage.image = d
                    backgroundImage.alpha = 1
                }
                if let d = layout.primaryColor {
                    loginButton.backgroundColor = d
                    logoImage.tintColor = d
                }
                if let d = layout.secondaryColor {
                    loginButton.setTitleColor(d, for: .normal)
                    lineLogin.backgroundColor = d
                    linePassword.backgroundColor = d
                    userIcon.tintColor = d
                    passwordIcon.tintColor = d
                }
            case .Advanced(let layout):
                let image = layout.image
                if let a = image.color1 {
                    logoImage.tintColor = a
                }
                if let a = image.color2 {
                    logoImage.tintColor = a
                }
                if let a = image.backgroundColor {
                    logoImage.backgroundColor = a
                }
                if let a = image.image {
                    logoImage.image = a
                }
                
                let button = layout.button
                if let a = button.backgroundColor {
                    loginButton.backgroundColor = a
                }
                if let a = button.cornerRadius {
                    loginButton.layer.cornerRadius = CGFloat(a)
                }
                if let a = button.font {
                    loginButton.titleLabel?.font = a
                }
                if let a = button.fontColor {
                    loginButton.setTitleColor(a, for: .normal)
                }
                if let a = button.alpha {
                    loginButton.alpha = CGFloat(a)
                }
                
                let main = layout.mainView
                if let a = main.alpha {
                    backgroundImage.alpha = CGFloat(a)
                }
                if let a = main.image {
                    backgroundImage.image = a
                }
                if let a = main.backgroundColor {
                    self.view.backgroundColor = a
                    backgroundImage.backgroundColor = a
                }
                
                changeIconLayout(icon: userIcon, iconLayout: layout.usernameIcon)
                changeIconLayout(icon: passwordIcon, iconLayout: layout.passwordIcon)
                changeTextFieldLayout(textField: userIdField, labelLayout: layout.usernameLabel)
                changeTextFieldLayout(textField: passwordField, labelLayout: layout.passwordLabel)
                changeLineLayout(line: lineLogin, lineLayout: layout.line1)
                changeLineLayout(line: linePassword, lineLayout: layout.line2)
            }
            
            
        }
        
    }
    
    func changeLineLayout(line:UILabel,lineLayout:LineConfig) {
        if let a = lineLayout.alpha {
            line.alpha = CGFloat(a)
        }
        if let a = lineLayout.color {
            line.backgroundColor = a
        }
    }
    
    func changeIconLayout(icon:UIImageView,iconLayout:IconConfig) {
        if let a = iconLayout.backgroundColor {
            icon.backgroundColor = a
        }
        if let a = iconLayout.color {
            icon.tintColor = a
        }
        if let a = iconLayout.image {
            icon.image = a
        }
    }
    
    func changeTextFieldLayout(textField:UITextField,labelLayout:LabelConfig) {
        if let a = labelLayout.backgroundColor {
            textField.backgroundColor = a
        }
        if let a = labelLayout.font {
            textField.font = a
        }
        if let a = labelLayout.fontColor {
            textField.textColor = a
            let b = a.withAlphaComponent(0.7)
            if let txt = textField.placeholder {
                textField.attributedPlaceholder = NSAttributedString(string: txt,
                                                                   attributes: [NSAttributedString.Key.foregroundColor: b])
            } else {
                
                textField.attributedPlaceholder = NSAttributedString(string: "",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: b])
            }
        }
    }
}
