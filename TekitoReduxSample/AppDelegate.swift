//
//  AppDelegate.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/04/27.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit
import ReSwift

let mainStore = Store(reducer: appReducer, state: nil)

func appPrint(_ items: Any...) {
    #if DEBUG
    Swift.print(items)
    #endif
}

func appDump<T>(_ value: T) {
    #if DEBUG
    Swift.dump(value)
    #endif
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    mainStore.subscribe(self)
    window = UIWindow(frame: UIScreen.main.bounds)
    let vc = R.storyboard.userArticleList.instantiateInitialViewController()!
    vc.inject(listState: mainStore.state.home, listActionCreator: HomeStateActionCreator())
    let nav = UINavigationController(rootViewController: vc)
    window?.rootViewController = nav
    window?.makeKeyAndVisible()
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }

}
