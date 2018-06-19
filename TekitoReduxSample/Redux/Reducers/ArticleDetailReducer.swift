//
//  ArticleDetailReducer.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/19.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

func articleDetailReducer(action: Action, state: ArticleDetailState?) -> ArticleDetailState {
    let currentState = state ?? ArticleDetailState()
    var newState = currentState
    switch action {
    case let action as ArticleDetailState.ArticleDetailIdAction:
        newState.update(articleId: action.articleId)
    case let action as ArticleDetailState.ArticleDetailAction:
        newState.update(articleDetail: action.articleDetail)
    default: break
    }
    return newState
}
