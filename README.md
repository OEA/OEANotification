OEANotification
============
OEANotification is an iOS library which provides to create notifications and customize them easily.
You can create notifications with just one line of code ,if you are bored UIAlertView.

[![CocoaPods](https://img.shields.io/cocoapods/v/OEANotification.svg)](https://github.com/OEASLAN/OEANotification)

# Installation

## Cocoapods

`pod 'OEANotification', '~> 0.1.0'`

# Usage

Set a main view controller

```swift
import UIKit
import OEANotification

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        OEANotification.setDefaultViewController(self)
        OEANotification.notify("Test Title", subTitle: "Test SubTitle", image: nil, type: NotificationType.Success, isDismissable: true)
    }
}
```

# License

OEANotification is released under an MIT license. See LICENSE for more information.