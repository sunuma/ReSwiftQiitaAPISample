//
//  UserArticleListStateAction.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/20.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation
import ReSwift

extension UserArticleListState {
    struct UserArticleListUserIdAction: Action {
        let userId: String
    }
    
    struct UserArticleListRefreshAction: Action {
        let page: Int
        let isRefresh: Bool
    }
    
    struct UserArticleResultAction: Action {
        let result: Decodable
    }
    
    struct UserArticleListShowMoreLoadingAction: Action {
        let showMoreLoading: Bool
    }
    
    struct UserMoreArticleResultAction: Action {
        let result: Decodable
    }
    
    struct UserArticleResultErrorAction: Action {
        let error: ApiError
    }
    
    struct UserFinishMoreArticleAction: Action {
        let finishMoreUserArticle: Bool
    }
    
    struct UserResetArticleStateAction: Action {
        let userId: String? = nil
        let pageNumber: Int = 1
        let articleList: [ArticleModel]? = nil
        let errorMessage: String? = nil
        let isRefresh: Bool = false
        let showMoreLoading: Bool = false
        let finishMoreUserArticle: Bool = false
    }
}
