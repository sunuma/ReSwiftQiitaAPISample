//
//  HomeReducer.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/12.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

func homeStateReducer(action: Action, state: HomeState?) -> HomeState {
    let currentState = state ?? HomeState()
    var newState = currentState
            
    switch action {
    case let action as HomeState.HomeArticleResultAction:
        if let articleList = action.result as? ArticleListModel {
            newState.update(articleList: articleList.articleModels)
        }
    case let action as HomeState.HomeArticleResultErrorAction:
        newState.updateErrorMessage(error: action.error)
//    case let action as HomeState.HomeFinishMoreArticleAction:
    case let action as HomeState.HomeMoreArticleResultAction:
        if let articleList = action.result as? [ArticleModel] {
            newState.append(articleList: articleList)
        }
    default: break
    }
    return newState
}
