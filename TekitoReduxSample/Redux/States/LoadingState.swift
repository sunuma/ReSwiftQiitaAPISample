//
//  LoadingState.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

struct LoadingState {
    private(set) var isLoading: Bool = false
}

extension LoadingState {
    mutating func updateIsLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
