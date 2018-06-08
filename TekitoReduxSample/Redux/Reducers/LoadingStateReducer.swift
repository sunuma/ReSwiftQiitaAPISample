//
//  LoadingStateReducer.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

func loadingStateReducer(_ action: Action, _ state: AppState?) -> AppState {
    let state = state ?? AppState()
    var newState = state
    var loadingState = newState.loading
    switch action {
    case let action as LoadingState.LoadingAction:
        loadingState.updateIsLoading(isLoading: action.isLoading)
    default: break
    }
    newState.loading = loadingState
    return newState
}
