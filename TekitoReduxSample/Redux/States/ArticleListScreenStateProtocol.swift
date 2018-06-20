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
    mutating func update(articleList: [ArticleModel]?) {
        self.articleList = articleList
        incrementPageNumber()
    }
    
    mutating func append(articleList: [ArticleModel]?) {
        guard let list = articleList else { return }
        self.articleList?.append(contentsOf: list)
        incrementPageNumber()
    }
    
    mutating func update(error: ApiError) {
        self.errorMessage = error.errorDescription()
    }
    
    mutating func update(userId: String!) {
        self.userId = userId
    }
    
    mutating func update(pageNumber: Int) {
        self.pageNumber = pageNumber
    }
    
    mutating func update(showMoreLoading: Bool) {
        self.showMoreLoading = showMoreLoading
    }
    
    mutating func incrementPageNumber() {
        pageNumber += 1
    }
}

extension ArticleListScreenStateProtocol {
    func fetchArticle(index: Int) -> ArticleModel {
        guard let articleList = articleList, articleList.count > index else {
            return ArticleModel()
        }
        return articleList[index]
    }
    
    func hasError() -> Bool {
        return errorMessage != nil
    }
    
    func fetchArticleListCount() -> Int {
        return articleList?.count ?? 0
    }
}
