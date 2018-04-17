//
//  LoginViewController_Cappriola.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 14/03/2018.
//

import UIKit

////////////////////////////////////
// MARK: Connection Methods
////////////////////////////////////

public enum ConnectionConfig {
    case LaravelPassportClientPassword(requestTokenEndpoint:String,validadeTokenEndpoint:String,clientId:String,clientSecret:String)
}

extension LoginViewController : CappriolaRequestHelperDelegate {
    func requestSuccess(message: String, requestType: RequestType, data: Data) {
        let myDictionary = CappriolaHTTPRequest.getJSONfrom(data: data)
        
        if let myToken = myDictionary[tokenField] as? String {
            createOrUpdateKeyChainAccount(myToken, completion: { (token) in
                presentNextViewAnimation()
            })
            
        }
        
    }
    
    func requestFail(message: CappriolaError, requestType: RequestType) {
        
        self.animateLoginbutton()
        
        switch message {
        case .TransportSecurity:
            self.present(Alerts().accessDeniedWithTransportSecurity(), animated: true, completion: nil)
        default:
            self.present(Alerts().accessDenied(), animated: true, completion: nil)
        }
    }
}

////////////////////////////////////
// MARK: Login Method
////////////////////////////////////

extension LoginViewController {
    
    public func login(username:String,password:String) {
        switch connectionConstant! {
        case .LaravelPassportClientPassword(let requestTokenEndpoint, _, let clientId,let clientSecret):
            cappriolaRequestHelper.login(header: ["Content-Type":"application/json"], body: ["grant_type":"password","client_id":clientId,"client_secret":clientSecret,"username":username,"password":password], method: "POST", endPoint: requestTokenEndpoint)
        }
    }
}
