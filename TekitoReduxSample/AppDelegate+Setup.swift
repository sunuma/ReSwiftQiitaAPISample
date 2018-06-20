//
//  AppDelegate+Setup.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/05/09.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
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

extension AppDelegate: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    func newState(state: AppState) {
        
    }
}
