//
//  AppDelegate.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configWindow()
        return true
    }
}

extension AppDelegate {
    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.makeKeyAndVisible()
            window.backgroundColor = .white
            window.rootViewController = CalendarViewController()
        }
    }
}
