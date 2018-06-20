//
//  ArticleDetailStateAction.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/18.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

extension ArticleDetailState {
    struct ArticleDetailIdAction: Action {
        let articleId: String
    }
    
    struct ArticleDetailAction: Action {
        let articleDetail: ArticleModel
    }
    
    struct ArticleDetailErrorAction: Action {
        let error: ApiError
    }
    
    struct FetchingStockStatusAction: Action {
        let isFetchingStockStatus: Bool
    }
    
    struct ArticleDetailHasStockAction: Action {
        let hasStock: Bool
    }
    
    struct UserArticleDetailErrorAction: Action {
        let error: ApiError
    }
}
