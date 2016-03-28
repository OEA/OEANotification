# OEANotification

[![Version](https://img.shields.io/cocoapods/v/OEANotification.svg?style=flat)](http://cocoapods.org/pods/OEANotification)
[![License](https://img.shields.io/cocoapods/l/OEANotification.svg?style=flat)](http://cocoapods.org/pods/OEANotification)
[![Platform](https://img.shields.io/cocoapods/p/OEANotification.svg?style=flat)](http://cocoapods.org/pods/OEANotification)
[![Swift 2.1](https://img.shields.io/badge/Swift-2.1-orange.svg?style=flat)](https://developer.apple.com/swift/)

OEANotification is an iOS library which provides to create notifications and customize them easily.
You can create notifications with just one line of code ,if you are bored UIAlertView.

![](ScreenRecord/OEANotification.gif)


## Usage

```swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        OEANotification.setDefaultViewController(self)
        // to create simple success notification
        OEANotification.notify("Test Title", subTitle: "Test SubTitle", image: nil, type: NotificationType.Success, isDismissable: true)
        // to create info notification
        //OEANotification.notify("Test Title", subTitle: "Test SubTitle", image: nil, type: NotificationType.Info, isDismissable: true)
        // to create warning notification
        //OEANotification.notify("Test Title", subTitle: "Test SubTitle", image: nil, type: NotificationType.Warning, isDismissable: true)
        // to create completion handler based notification
        OEANotification.notify("Test Title", subTitle: "Test Subtitle", image: nil, type: .Success, isDismissable: true, completion: { () -> Void in
                print("completed")
            }, touchHandler: nil)
        // to create touchHandler based notificaiton
        OEANotification.notify("Test Title", subTitle: "Test Subtitle", image: nil, type: .Success, isDismissable: true, completion: { () -> Void in
                print("completed")
            }) { () -> Void in
                print("touched event")
    }
}
```

## Installation

OEANotification is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OEANotification"
```

#### Roadmap 

- [X] Default Notification Types (Warning, Info, Success)
- [ ] Custom Notification Type
- [X] Device rotation handling
- [X] Completion Handler based notification
- [X] View Tapped Handler based notification
- [ ] Creating big example of OEANotification
- [ ] UI Tests
- [ ] Setup Travis


## Author

Ömer Aslan, omeremreaslan@gmail.com

## License

OEANotification is available under the MIT license. See the LICENSE file for more info.


