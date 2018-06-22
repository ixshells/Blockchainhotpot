//
//  AppDelegate.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 26/04/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import UIKit
import AlicloudUtils

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let man = ALBBMANAnalytics.getInstance()
        man?.initWithAppKey("24882007", secretKey: "1019ed7395c04cd019326bd3c745d4ab")
        man?.turnOnDebug()
        man?.autoInit()

        return true
    }
}
