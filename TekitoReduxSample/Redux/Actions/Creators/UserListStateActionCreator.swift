//
//  UserListStateActionCreator.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/20.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

struct UserListStateActionCreator: ListStateActionCreatorProtocol {
    func generateListUserIdAction() -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserArticleListUserIdAction(userId: state.userArticleList.userId)
        }
    }
    
    func generateRefreshAction(_ page: Int, isRefresh: Bool) -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserArticleListRefreshAction(page: page, isRefresh: isRefresh)
        }
    }
    
    func generateResultAction(_ result: Decodable) -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserArticleResultAction(result: result)
        }
    }
    
    func generateResultErrorAdtion(_ error: ApiError) -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserArticleResultErrorAction(error: error)
        }
    }
    
    func generateShowMoreLoadingAction(_ isLoading: Bool) -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserArticleListShowMoreLoadingAction(showMoreLoading: isLoading)
        }
    }
    
    func generateMoreListResultAction(_ result: Decodable) -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserMoreArticleResultAction(result: result)
        }
    }
    
    func generateFinishMoreListAction(_ isFinish: Bool) -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserFinishMoreArticleAction(finishMoreUserArticle: isFinish)
        }
    }
    
    func generateResetListAction() -> (AppState, Store<AppState>) -> Action? {
        return { (state: AppState, store: Store<AppState>) in
            return UserArticleListState.UserResetArticleStateAction()
        }
    }
}
