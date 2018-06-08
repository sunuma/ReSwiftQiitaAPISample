//
//  HomeStateAction.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

extension HomeState {
    
    struct HomeRefreshAction: Action {
        let page: Int
        let isRefresh: Bool
    }
    
    struct HomeArticleResultAction: Action {
        let result: Decodable
    }
    
    struct HomeArticleResultErrorAction: Action {
        let error: ApiError
    }
    
    struct HomeShowMoreLoadingAction: Action {
        let isLoading: Bool
    }
    
    struct HomeMoreArticleResultAction: Action {
        let result: Decodable
    }
    
    struct HomeFinishMoreArticleAction: Action {
        let isFinish: Bool
    }
}
