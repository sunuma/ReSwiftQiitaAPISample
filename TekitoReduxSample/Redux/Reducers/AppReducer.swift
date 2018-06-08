//
//  AppReducer.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(_ action: Action, _ state: AppState?) -> AppState {
    return state ?? AppState()
}
