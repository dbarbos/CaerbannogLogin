//
//  LoginLayout.swift
//  CaerbannogLogin
//
//  Created by Leonardo Geus on 14/03/2018.
//

import UIKit

public struct ButtonConfig {
    public var backgroundColor:UIColor?
    public var font:UIFont?
    public var fontColor:UIColor?
    public var cornerRadius:Float?
}

public struct LabelConfig {
    public var backgroundColor:UIColor?
    public var font:UIFont?
    public var fontColor:UIColor?
}

public struct ImageConfig {
    public var image:UIImage?
    public var backgroundColor:UIColor?
    public var color1:UIColor?
    public var color2:UIColor?
}

public struct IconConfig {
    public var image:UIImage?
    public var backgroundColor:UIColor?
    public var color:UIColor?
}

public struct LineConfig {
    public var color:UIColor?
    public var alpha:Float?
}

public struct MainView {
    public var backgroundColor:UIColor?
    public var alpha:Float?
}

public protocol LoginLayout {
    
}

public enum Layout {
    case Simple(layout:SimpleLayout)
    case Advanced(layout:AdvancedLayout)
}

public class AdvancedLayout:LoginLayout {
    
    public var button = ButtonConfig()
    public var usernameLabel = LabelConfig()
    public var passwordLabel = LabelConfig()
    public var image = ImageConfig()
    public var usernameIcon = IconConfig()
    public var passwordIcon = IconConfig()
    public var line1 = LineConfig()
    public var line2 = LineConfig()
    public var mainView = MainView()
    
    public init() {
        
    }
    
}

public class SimpleLayout:LoginLayout {
    
    public var primaryColor:UIColor?
    public var secondaryColor:UIColor?
    public var backgroundImage:UIImage?
    
    public init() {
        
    }
}
