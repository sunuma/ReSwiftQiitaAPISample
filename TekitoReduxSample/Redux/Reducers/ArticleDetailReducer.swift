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
    case let action as ArticleDetailState.ArticleDetailHasStockAction:
        let stockStatus = StockStatus(isStock: action.hasStock)
        newState.update(stockStatus: stockStatus)
    case let action as ArticleDetailState.ArticleDetailErrorAction:
        newState.update(error: action.error)
    case let action as ArticleDetailState.FetchingStockStatusAction:
        newState.update(fetchingStockStatus: action.isFetchingStockStatus)
    default: break
    }
    return newState
}
