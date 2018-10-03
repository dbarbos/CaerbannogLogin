![](https://i.imgur.com/tHLDFmC.png)

> A framework to create a secure and easy login system with customizable layout.

![Bitrise Status](https://app.bitrise.io/app/99d8db7b4ecd747c/status.svg?token=ZA9gXcaIpYeQiexVoNlxfQ)

## Requirements

  - Swift 4.2+
  - Xcode 10.0+

## Installation

CaerbannogLogin is available through CocoaPods. To install it, simply add the following line to your Podfile:

```swift
pod 'CaerbannogLogin', :git => 'https://github.com/dbarbos/CaerbannogLogin.git'
```

## Usage example

<p align="center">
<img src="https://media.giphy.com/media/2yuOapMEOjp4M1rcxu/giphy.gif" width="80%">
</p>


1) Import the framework CaerbannogLogin in your AppDelegate;
2) Configure the way to connect to your server creating a ConnectionConfig object in didFinishLaunchingWithOptions. E.g.: the following example is to configure a Laravel Passport Client Password.

```swift
let connection:ConnectionConfig = .LaravelPassportClientPassword(requestTokenEndpoint: String, validadeTokenEndpoint: String, clientId: String, clientSecret: String)
```

3) Initialize the framework with CaerbanoggLogin.shared.initialize with: <br />
  - Your connection object created in item 2; <br />
  - A view controller to proceed after login process is completed. <br />

```swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let initialViewController = storyboard.instantiateViewController(withIdentifier: "OtherViewController")

CaerbanoggLogin.shared.initialize(whereNextViewControllerIs: initialViewController, connection: connection)
```

4) Customize passing a layout to CaerbanoggLogin.shared.setLayout(). There is two types of layout configuration, to simplify create a Simple Layout and change there properties.

```swift
let simpleLayout = SimpleLayout()
simpleLayout.primaryColor = UIColor
simpleLayout.secondaryColor  = UIColor
simpleLayout.backgroundImage = UIImage  
CaerbanoggLogin.shared.setLayout(layout: .Simple(layout: simpleLayout))
```

5) Lastly, show your login controller with the method .showController()

```swift
CaerbanoggLogin.shared.showController()
```

**EXTRAS** <br />
6) If you want to customize all elements separately, create an AdvanceLayout and change there properties. After, assign this new object to CaerbanoggLogin.shared.setLayout() method

```swift
let advancedLayout = AdvancedLayout()
advancedLayout.button.font = UIFont.systemFont(ofSize: 32)
CaerbanoggLogin.shared.setLayout(layout: .Advanced(layout: advancedLayout))
```
7) To logout, use the function logout assigning a UIViewController to be the next controller in flow after a new login:

```swift
CaerbanoggLogin.shared.logout(nextViewController: UIViewController())
```

## Authors

[dbarbos](https://github.com/dbarbos), dilermando.barbosa@gmail.com<br/>
[leodegeus7](https://github.com/leodegeus7), leonardodegeus@gmail.com

## Release History

* 0.0.1
    * First Commit
* 0.0.2
    * Created logout method and updaded DemoApp
* 0.0.40
    * Updated to Swift 4.2;
    * Added protection space for CredStore;
    * Fix biometry challenge to include face ID;
* 0.0.41
    * Fixed problem with LAError
    * Created animation for biometric identification 


## License

CaerbannogLogin is available under the MIT license. See the LICENSE file for more info.
