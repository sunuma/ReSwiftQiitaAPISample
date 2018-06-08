//
//  ListStateActionCreator.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

protocol ListStateActionCreatorProtocol {
    func generateListUserIdAction() -> Store<AppState>.ActionCreator
    func generateRefreshAction(_ page: Int, isRefresh: Bool) -> Store<AppState>.ActionCreator
    func generateResultAction(_ result: Decodable) -> Store<AppState>.ActionCreator
    func generateResultErrorAdtion(_ error: ApiError) -> Store<AppState>.ActionCreator
    func generateShowMoreLoadingAction(_ isLoading: Bool) -> Store<AppState>.ActionCreator
    func generateFinishMoreListAction(_ isFinish: Bool) -> Store<AppState>.ActionCreator
    func generateResetListAction() -> Store<AppState>.ActionCreator
}

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
