//
//  AppReducer.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(loading: loadingStateReducer(action: action, state: state?.loading),
                    home: homeStateReducer(action: action, state: state?.home),
                    articleDetail: articleDetailReducer(action: action, state: state?.articleDetail))
}
