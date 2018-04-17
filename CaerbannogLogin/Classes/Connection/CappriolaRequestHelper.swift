//
//  CappriolaRequestHelper.swift
//  Mobile-Reports
//
//  Created by DILERMANDO BARBOSA JR on 08/03/17.
//  Copyright © 2017 T-Systems Brasil. All rights reserved.
//

import Foundation
import UIKit

protocol CappriolaRequestHelperDelegate {
    func requestSuccess(message: String, requestType: RequestType, data: Data)
    func requestFail(message: CappriolaError, requestType: RequestType)
}

enum RequestType: String {
    case RequestToken = "Request Token"
    case ValidateToken = "Validate Token"
}

class CappriolaRequestHelper: NSObject {
    
    
    var delegate: CappriolaRequestHelperDelegate?
    let cappriola = CappriolaHTTPRequest()
    
    
    func login(header: [String:String], body: [String:String], method: String, endPoint: String) {
        
        var request = URLRequest(url: URL(string: endPoint)!)
        request.httpMethod = method
        request.timeoutInterval = 15.0
        
        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let data = body.toJSON() {
            request.httpBody = data
        }
        cappriola.getData(request: request, success: { (response, data) -> () in
            self.delegate?.requestSuccess(message: "Token granted!", requestType: .RequestToken, data: data)
            
            
        }, error: { (message, response) -> () in
            self.delegate?.requestFail(message: message, requestType: .RequestToken)
            
        }) {
        }
        
    }
    
}

extension Dictionary where Key == String, Value == String {
    func asHttpBody() -> String {
        
        var result = ""
        
        for e in self {
            result = result + e.key + "=" + e.value + "&"
        }
        
        result.removeLast()
        
        return result
    }
    
    func toJSON() -> Data? {
            return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])

    }
}
