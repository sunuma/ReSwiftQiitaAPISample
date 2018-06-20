//
//  UserArticleListState.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/20.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

struct UserArticleListState: ArticleListScreenStateProtocol {
    let title: String = "投稿一覧"
    var userId: String!
    var pageNumber: Int = 1
    var articleList: [ArticleModel]?
    var errorMessage: String?
    var isRefresh: Bool = false
    var showMoreLoading: Bool = false
    var finishMoreUserArticle: Bool = false
}
