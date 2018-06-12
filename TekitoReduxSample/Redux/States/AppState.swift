//
//  AppState.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/05/09.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var loading: LoadingState
    var home: HomeState
}
