//
//  ArticleListScreenStateProtocol.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

protocol ArticleListScreenStateProtocol {
    var title: String { get }
    var pageNumber: Int { get set }
    var articleList: [ArticleModel]? { get set }
    var errorMessage: String? { get set }
    var isRefresh: Bool { get set }
    var showMoreLoading: Bool { get set }
    var userId: String! { get set }
    var finishMoreUserArticle: Bool { get set }
}

extension ArticleListScreenStateProtocol {
    func fetchArticle(index: Int) -> ArticleModel {
        guard let articleList = articleList, articleList.count > index else {
            return ArticleModel()
        }
        return articleList[index]
    }
    
    func fetchArticleListCount() -> Int {
        return articleList?.count ?? 0
    }
}
