//
//  AppDelegate.swift
//  CaerbannogLogin
//
//  Created by leodegeus7 on 03/13/2018.
//  Copyright (c) 2018 leodegeus7. All rights reserved.
//

import UIKit
import CaerbannogLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")

        let connection:ConnectionConfig = .LaravelPassportClientPassword(requestTokenEndpoint: "https://shift.t-systems.com.br/oauth/token", validadeTokenEndpoint: "", clientId: "2", clientSecret: "lmCZQrjQ1reN3XXV00m3GAJ2n7caFya3mxD3VXZf")
        

        
        CaerbanoggLogin.shared.initialize(whereNextViewControllerIs: initialViewController, connection: connection)
        CaerbanoggLogin.shared.useBiometry(messageToShow: "Please, confirm the Biometry")
        
        
        let advancedLayout = AdvancedLayout()
        advancedLayout.image.image = #imageLiteral(resourceName: "logoMain.png")
        advancedLayout.button.backgroundColor = UIColor(red: 117/255, green: 110/255, blue: 133/255, alpha: 1)
        advancedLayout.button.font = UIFont.systemFont(ofSize: 16)
        advancedLayout.button.alpha = 1
        advancedLayout.line1.color = UIColor.white
        advancedLayout.line1.alpha = 0.9
        advancedLayout.line2.color = UIColor.white
        advancedLayout.usernameLabel.fontColor = UIColor.white
        advancedLayout.passwordLabel.fontColor = UIColor.white
        advancedLayout.mainView.image = #imageLiteral(resourceName: "fundoMain.png")
        
        
        CaerbanoggLogin.shared.setLayout(layout: .Advanced(layout: advancedLayout))
        CaerbanoggLogin.shared.showController()
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

