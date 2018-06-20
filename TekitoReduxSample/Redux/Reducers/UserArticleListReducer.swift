//
//  UserArticleListReducer.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/20.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

func userArticleListReducer(action: Action, state: UserArticleListState?) -> UserArticleListState {
    let currentState = state ?? UserArticleListState()
    var newState = currentState
    switch action {
    case let action as UserArticleListState.UserArticleListUserIdAction:
        newState.update(userId: action.userId)
    case let action as UserArticleListState.UserArticleResultAction:
        if let articleList = action.result as? ArticleListModel {
            newState.update(articleList: articleList.articleModels)
        }
    case let action as UserArticleListState.UserArticleResultErrorAction:
        newState.update(error: action.error)
    case let action as UserArticleListState.UserArticleListRefreshAction:
        newState.update(pageNumber: action.page)
    default: break
    }
    return newState
}
