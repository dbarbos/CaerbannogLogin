//
//  Login.swift
//  CappriolaLogin
//
//  Created by Diler Barbosa on 28/11/17.
//  Copyright © 2017 Diler Barbosa. All rights reserved.
//

import Foundation

public class Login {
    
    public enum Method : String{
        case GET = "get"
        case POST = "post"
    }
    
    public var method: Method
    
    public init(method: Method) {
        self.method = method
    }
}
