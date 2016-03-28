//
//  OEANotification.swift
//  OEANotification
//
//  Created by Ömer Emre Aslan on 15/11/15.
//  Copyright © 2015 omer. All rights reserved.
//

import UIKit

public class OEANotification : UIView {
    
    static let constant = Constants()
    static var rect = CGRectMake(constant.nvMarginLeft, constant.nvStartYPoint, OEANotification.viewController.view.frame.width - constant.nvMarginLeft - constant.nvMarginRight, constant.nvHeight)
    static var viewController: UIViewController!
    static var notificationCount = 0
    static var rotated:Bool = false
    
    // MARK: - Initial notification methods
    
     /**
     Initial static method of creating notification.
     
     - since:                   0.1.0
     - author:                  @OEASLAN - omeremreaslan@gmail.com
     - parameter title:         The title of notification.
     - parameter subTitle:      The subtitle of notification.
     - parameter type:          The type of notification which are Success, Warning, and Info.
     - parameter isDismissable: The notification center from which the notification should be dispatched.
     - return:                  void
     */
    static public func notify(
        title: String,
        subTitle: String,
        type: NotificationType,
        isDismissable: Bool
        ){
            self.notify(title, subTitle: subTitle, image: nil, type: type, isDismissable: isDismissable)
    }
    
    /**
     Initial static method of creating notification.
     
     - since:                   0.1.0
     - author:                  @OEASLAN - omeremreaslan@gmail.com
     - parameter title:         The title of notification.
     - parameter subTitle:      The subtitle of notification.
     - parameter type:          The type of notification which are Success, Warning, and Info.
     - parameter image:         The main icon image of notification like avatar, success, warning etc. icons
     - parameter isDismissable: The notification center from which the notification should be dispatched.
     - return:                  void
     */
    static public func notify(
        title: String,
        subTitle: String,
        image: UIImage?,
        type: NotificationType,
        isDismissable: Bool
        ) {
            
            self.notify(title, subTitle: subTitle, image: image, type: type, isDismissable: isDismissable, completion: nil, touchHandler: nil)
    }
    
    /**
     Initial static method of creating notification.
     
     - since:                   0.1.0
     - author:                  @OEASLAN - omeremreaslan@gmail.com
     - parameter title:         The title of notification.
     - parameter subTitle:      The subtitle of notification.
     - parameter type:          The type of notification which are Success, Warning, and Info.
     - parameter image:         The main icon image of notification like avatar, success, warning etc. icons
     - parameter completion:    The main icon image of notification like avatar, success, warning etc. icons
     - parameter isDismissable: The notification center from which the notification should be dispatched.
     - return:                  void
     */
    static public func notify(
        title: String,
        subTitle: String,
        image: UIImage?,
        type: NotificationType,
        isDismissable: Bool,
        completion: (() -> Void)?,
        touchHandler: (() ->Void)?
        ) {
            let notificationView: NotificationView = NotificationView(
                frame: rect,
                title: title,
                subTitle: subTitle,
                image: image,
                type: type,
                completionHandler: completion,
                touchHandler: touchHandler,
                isDismissable: isDismissable
            )
            
            OEANotification.notificationCount++
            OEANotification.removeOldNotifications()
            
            print(OEANotification.viewController.view.frame)
            if OEANotification.viewController.navigationController != nil {
                OEANotification.viewController.navigationController!.view.addSubview(notificationView)
            } else {
                OEANotification.viewController.view.addSubview(notificationView)
            }
    }
    
    /**
     Sets the default view controller as a main view controller.
     
     - since:                    0.1.0
     - author:                   @OEASLAN - omeremreaslan@gmail.com
     - parameter viewController: The main controller which shows the notification.
     - return:                   void

     */
    static public func setDefaultViewController (viewController: UIViewController) {
        self.viewController = viewController
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotateRecognizer", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    
    // MARK: - Helper methods
    static public func removeOldNotifications() {
        if OEANotification.viewController.navigationController != nil {
            for subUIView in OEANotification.viewController.navigationController!.view.subviews as [UIView] {
                if subUIView.isKindOfClass(NotificationView) {
                    let view: NotificationView = subUIView as! NotificationView
                    view.notificationTimer.invalidate()
                    subUIView.removeFromSuperview()
                    OEANotification.notificationCount--
                }
            }
        } else {
            for subUIView in OEANotification.viewController.view.subviews as [UIView] {
                if subUIView.isKindOfClass(NotificationView) {
                    let view: NotificationView = subUIView as! NotificationView
                    view.notificationTimer.invalidate()
                    subUIView.removeFromSuperview()
                    OEANotification.notificationCount--
                }
            }
        }
    }
    
    // Close active notification
    static public func closeNotification() {
        if OEANotification.viewController.navigationController != nil {
            for subUIView in OEANotification.viewController.navigationController!.view.subviews as [UIView] {
                if subUIView.isKindOfClass(NotificationView) {
                    let view: NotificationView = subUIView as! NotificationView
                    view.close()
                }
            }
        } else {
            for subUIView in OEANotification.viewController.view.subviews as [UIView] {
                if subUIView.isKindOfClass(NotificationView) {
                    let view: NotificationView = subUIView as! NotificationView
                    view.close()
                }
            }
        }
    }
    
    
    // Checking device's rotation process and remove notifications to handle UI conflicts.
    static public func rotateRecognizer() {
        removeOldNotifications()
        UIApplication.sharedApplication().delegate?.window??.windowLevel = UIWindowLevelNormal
        self.rect = CGRectMake(constant.nvMarginLeft, constant.nvStartYPoint, OEANotification.viewController.view.frame.width - constant.nvMarginLeft - constant.nvMarginRight, constant.nvHeight)
    }
    
    
}

public enum NotificationType {
    case Warning
    case Success
    case Info
}



