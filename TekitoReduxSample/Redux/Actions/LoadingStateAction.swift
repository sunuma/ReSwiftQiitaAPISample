//
//  LoadingStateAction.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

extension LoadingState {
    struct LoadingAction: Action {
        let isLoading: Bool
    }
}
