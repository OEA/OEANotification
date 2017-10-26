//
//  NotificationView.swift
//  OEANotification
//
//  Created by Ömer Emre Aslan on 24/11/15.
//  Copyright © 2015 omer. All rights reserved.
//

import Foundation
import UIKit

class NotificationView : UIView{
    let bundle = Bundle(identifier: "com.omer.OEANotification")
    var notificationTimer: Timer!
    var title: String?
    var subTitle: String?
    var image: UIImage?
    var type: NotificationType?
    var isDismissable: Bool = false
    let constants: Constants = Constants()
    var completionHandler:(() -> Void)?
    var touchHandler:(() -> Void)?

    init(frame: CGRect, title: String, subTitle: String?, type: NotificationType?, isDismissable: Bool) {
        super.init(frame: frame)
        self.initVariables(title: title, subTitle: subTitle, image: nil, type: type, completionHandler: nil, touchHandler: nil, isDismissable: isDismissable)
        self.setupNotification()

    }

    init(frame: CGRect, title: String, subTitle: String?, image: UIImage?, type: NotificationType?, isDismissable: Bool) {
        super.init(frame: frame)
        self.initVariables(title: title, subTitle: subTitle, image: image, type: type, completionHandler: nil, touchHandler: nil, isDismissable: isDismissable)
        self.setupNotification()
    }

    init(frame: CGRect, title: String, subTitle: String?, image: UIImage?, type: NotificationType?, completionHandler: (() -> Void)?, isDismissable: Bool) {
        super.init(frame: frame)
        self.initVariables(title: title, subTitle: subTitle, image: image, type: type, completionHandler: completionHandler, touchHandler: nil, isDismissable: isDismissable)
        self.setupNotification()
    }

    init(frame: CGRect, title: String, subTitle: String?, image: UIImage?, type: NotificationType?, completionHandler: (() -> Void)?, touchHandler: (() -> Void)?, isDismissable: Bool) {
        super.init(frame: frame)

        self.initVariables(title: title, subTitle: subTitle, image: image, type: type, completionHandler: completionHandler, touchHandler: touchHandler, isDismissable: isDismissable)
        self.setupNotification()
    }

    private func initVariables(title: String, subTitle: String?, image: UIImage?, type: NotificationType?, completionHandler: (() -> Void)?, touchHandler: (() -> Void)?, isDismissable: Bool) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.type = type
        self.completionHandler = completionHandler
        self.touchHandler = touchHandler
        self.isDismissable = isDismissable

    }

    private func setupNotification() {

        self.createBackground()
        if self.isDismissable {
            constants.nvPaddingRight += constants.nvdWidth
            self.createCloseButton()
            constants.nvPaddingRight += constants.nvdPaddingLeft
        }

        if self.image != nil {
            self.createImageView()
        }

        self.createTitleLabel()
        constants.nvPaddingTop += constants.nvtPaddingTop
        self.createSubtitleLabel()

        if self.isDismissable {
            constants.nvPaddingRight -= constants.nvdPaddingLeft
        }

        if self.touchHandler != nil {
            self.createTouchEvent()
        }
        self.addNotificationView()
    }

    private func createTouchEvent() {
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.addGestureRecognizer(tap)
    }

    func handleTap(recognizer: UITapGestureRecognizer) {
        self.touchHandler!()
    }

    private func addNotificationView() {
        NotificationView.animate(withDuration: constants.nvaTimer, animations: { () -> Void in
            self.frame.origin.y = self.constants.nvMarginTop

        }) { (flag) -> Void in
            if flag {
                if self.completionHandler != nil {
                    self.completionHandler!()
                }
            }

        }

        self.addTimer(time: constants.nvaShownTimer)
        UIApplication.shared.delegate?.window??.windowLevel = UIWindowLevelStatusBar+1


    }

    private func createBackground() {
        if type == NotificationType.Success {
            self.backgroundColor = UIColor(netHex: 0x7AB317)
        } else if type == NotificationType.Warning {
            self.backgroundColor = UIColor(netHex: 0xE46305)
        } else if type == NotificationType.Info {
            self.backgroundColor = UIColor(netHex: 0x016ABC)
        }
    }

    private func createTitleLabel() {
        let label = UILabel()
        label.frame = CGRect(x: constants.nvPaddingLeft, y: constants.nvPaddingTop, width: self.frame.width - constants.nvPaddingLeft - constants.nvPaddingRight, height: constants.nvtHeight)
        label.textAlignment = NSTextAlignment.left
        label.text = self.title
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor.white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 1
        self.addSubview(label)
    }

    private func createSubtitleLabel() {
        let subLabel = UILabel()
        subLabel.frame = CGRect(x: constants.nvPaddingLeft, y: constants.nvPaddingTop, width: self.frame.width - constants.nvPaddingLeft - constants.nvPaddingRight, height: constants.nvtHeight)
        subLabel.textAlignment = NSTextAlignment.left
        subLabel.text = self.subTitle
        subLabel.font = UIFont(name: "Helvetica", size: 9)
        subLabel.textColor = UIColor.white
        subLabel.layer.shadowColor = UIColor.black.cgColor
        subLabel.layer.shadowOpacity = 1
        subLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        subLabel.layer.shadowOpacity = 0.8
        subLabel.layer.shadowRadius = 1
        self.addSubview(subLabel)
    }

    private func createImageView() {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: constants.nvPaddingLeft, y: constants.nvPaddingTop, width: constants.nviHeight, height: constants.nviWidth))
        constants.nvPaddingLeft += constants.nviPaddingLeft
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.image = image
        self.addSubview(imageView)
    }

    private func createCloseButton() {
        let podBundle = Bundle(for: self.classForCoder)
        if let bundleURL = podBundle.url(forResource: "OEANotification", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let closeButton = UIButton()
                closeButton.frame = CGRect(x: self.frame.width - constants.nvPaddingRight, y: constants.nvdPaddingTop, width: constants.nvdHeight, height: constants.nvdWidth)

                closeButton.setImage(UIImage(named: "close", in: bundle, compatibleWith: nil), for: .normal)
                closeButton.addTarget(self, action: #selector(self.close), for: .touchDown)
                self.addSubview(closeButton)
            }
        }
    }

    private func addTimer(time: Double) {
        self.notificationTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(self.close), userInfo: nil, repeats: false)

    }


    @objc func close() {
        self.notificationTimer.invalidate()

        NotificationView.animate(withDuration: constants.nvaTimer, animations: { () -> Void in
            self.frame.origin.y = self.constants.nvStartYPoint
        }) { (Bool) -> Void in
            if OEANotification.notificationCount == 1 {
                UIApplication.shared.delegate?.window??.windowLevel = UIWindowLevelNormal
                OEANotification.removeOldNotifications()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
