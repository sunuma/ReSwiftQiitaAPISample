//
//  HomeStateActionCreator.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/20.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

struct HomeStateActionCreator: ListStateActionCreatorProtocol {
    func generateListUserIdAction() -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return nil
        }
    }
    
    func generateRefreshAction(_ page: Int, isRefresh: Bool) -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return HomeState.HomeRefreshAction(page: page, isRefresh: isRefresh)
        }
    }
    
    func generateResultAction(_ result: Decodable) -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return HomeState.HomeArticleResultAction(result: result)
        }
    }
    
    func generateResultErrorAdtion(_ error: ApiError) -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return HomeState.HomeArticleResultErrorAction(error: error)
        }
    }
    
    func generateShowMoreLoadingAction(_ isLoading: Bool) -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return HomeState.HomeShowMoreLoadingAction(isLoading: isLoading)
        }
    }
    
    func generateMoreListResultAction(_ result: Decodable) -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return HomeState.HomeMoreArticleResultAction(result: result)
        }
    }
    
    func generateFinishMoreListAction(_ isFinish: Bool) -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return HomeState.HomeFinishMoreArticleAction(isFinish: isFinish)
        }
    }
    
    func generateResetListAction() -> Store<AppState>.ActionCreator {
        return { (state: AppState, store: Store<AppState>) in
            return nil
        }
    }
}

