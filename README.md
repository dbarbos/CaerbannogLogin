# dbj-login
Generic login framework

# How to include login screen to your project

add the following code to you AppDelegate.swift DidFinishLaunchingWithOptions:

```swift
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let initialViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
    self.window?.rootViewController = LoginViewController(whereNextViewControllerIs: initialViewController)
    self.window?.makeKeyAndVisible()
```
