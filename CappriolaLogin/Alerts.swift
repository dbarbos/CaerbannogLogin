//
//  Alerts.swift
//  CappriolaLogin
//
//  Created by Diler Barbosa on 08/12/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import Foundation


public struct Alerts {
    public func passwordFieldMissing() -> UIAlertController {
        
        let alert = UIAlertController(title: "Try Again", message: "Your password is missing", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        return alert
    }
    
    public func userIdFieldMissing() -> UIAlertController {
        
        let alert = UIAlertController(title: "Try Again", message: "Your user ID is missing", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        return alert
    }
    
    public func noNetworkDetected() -> UIAlertController {
        
        let alert = UIAlertController(title: "Network Fail", message: "Please check your network settings!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        return alert
    }
}
