//
//  CappriolaHTTPRequest.swift
//  Mobile-Reports
//
//  Created by DILERMANDO BARBOSA JR on 08/03/17.
//  Copyright © 2017 T-Systems Brasil. All rights reserved.
//

import Foundation

public enum CappriolaError: String, Error {
    case Unauthorized = "Provided Login or Passcode is not valid"
    case UnexpectedFailure = "The server has returned an unexpected status message"
    case Offline = "No Internet connection"
    case MethodNotAllowed = "Status 405 Method not allowed"
    case BadRequest = "Status 400 Bad Request"
    case BadResponse = "Bad response from server!"
    case TransportSecurity = "Your transport security key in plist is not configured"
    case NoData = "Server is not responding! Please, try again later or check your settings."
    case ConversionFailed = "Error: conversion from JSON failed"
    case ServerNotFound = "Server not fount"
    case Default = ""
}

class CappriolaHTTPRequest: NSObject, NSURLConnectionDelegate, URLSessionDelegate {
    
    
    let sessionConfiguration = URLSessionConfiguration.default
    var session = URLSession()
    

    static func setRequest(url: String, httpHeader : [String:String]?, httpBody : String, httpMethod: String) -> URLRequest {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethod
        request.timeoutInterval = 15.0
        
        if httpHeader != nil {
            for (key, value) in httpHeader! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if httpBody != "" {
            request.httpBody = httpBody.data(using: .utf8)
        }
        
        return request
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let proposedCredential = URLCredential(user: "CappriolaAppUser", password: "CappriolaAppPassword", persistence: .permanent)
        
        let protectionSpace = URLProtectionSpace(host: "", port: 443, protocol: "https", realm: nil, authenticationMethod: nil)
        
        URLCredentialStorage.shared.setDefaultCredential(proposedCredential, for: protectionSpace)
       
        completionHandler(.useCredential, proposedCredential)
        
    }
    
    func cancel() {
        session.reset { 
            
        }
        session.invalidateAndCancel()
        session.finishTasksAndInvalidate()
        session.getAllTasks { (allTasks) in
            for task in allTasks {
                print(task.description)
                
            }
        }
    }
    
    
    func getData(request: URLRequest, success: @escaping (HTTPURLResponse?, Data) -> (), error: @escaping (_ message: CappriolaError, HTTPURLResponse?) -> (), completion: @escaping () -> ()) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        session = URLSession.init(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
    
        session.dataTask(with: request) { (data, response, erro) in
            
            DispatchQueue.main.async{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
       
            do{
                if response != nil {
                    guard let resp = response as? HTTPURLResponse else {
                        throw CappriolaError.BadResponse
                    }
                    
                    switch resp.statusCode {
                    case 200 :
                        success(response as! HTTPURLResponse?, data! as Data)
                        break
                    case 204 :
                        success(response as! HTTPURLResponse?, data! as Data)
                        break
                    case 400 :
                        error(CappriolaError.BadRequest, response as! HTTPURLResponse?)
                        break
                    case 404:
                        error(CappriolaError.ServerNotFound, response as! HTTPURLResponse?)
                        break
                    case 405 :
                        error(CappriolaError.MethodNotAllowed, response as! HTTPURLResponse?)
                        break
                    case 401 :
                        error(CappriolaError.Unauthorized, response as! HTTPURLResponse?)
                        break
                    default :
                        error(CappriolaError.UnexpectedFailure, response as! HTTPURLResponse?)
                        break
                    }
                    
                }
                else {
                    if let err = erro {
                        let description = err.localizedDescription
                        if (description.lowercased().range(of: "app transport security") != nil) {
                            error(CappriolaError.TransportSecurity, nil)
                        } else {
                            error(CappriolaError.Offline, nil)
                        }
                    } else {
                        error(CappriolaError.Offline, nil)
                    }
                    
                    
                }
                
                completion()
            
                
            }catch let error as NSError {
                print(error.debugDescription)
            }catch let error as CappriolaError {
                print(error.rawValue)
            }
            

        }.resume()
        
        
    }
    
    enum JSONError: String, Error {
        case NoData = "Server is not responding! Please, try again later or check your settings."
        case ConversionFailed = "Error: conversion from JSON failed"
    }
    
    static func isConvertibleToJSON(data: Data) -> Bool {
        
        do {
            guard (try JSONSerialization.jsonObject(with: data as Data, options: []) as? NSDictionary) != nil else {
                throw JSONError.ConversionFailed
            }
            return true
            
        } catch let error as JSONError {
            print(error.rawValue)
            return false
        } catch let error as NSError {
            print(error.debugDescription)
            return false
        }
        
    }
    
    static func getJSONfrom(data: Data) -> NSDictionary {
        
        if self.isConvertibleToJSON(data: data) {
            do {
                guard let json = try JSONSerialization.jsonObject(with: data as Data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                return json
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
        return NSDictionary()
        
    }
    
}
