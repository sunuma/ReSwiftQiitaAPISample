//
//  LoadingStateReducer.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

func loadingStateReducer(action: Action, state: LoadingState?) -> LoadingState {
    let state = state ?? LoadingState()
    var newState = state
    switch action {
    case let action as LoadingState.LoadingAction:
        newState.updateIsLoading(isLoading: action.isLoading)
    default: break
    }
    return newState
}
