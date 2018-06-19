//
//  ArticleDetailState.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/18.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

struct ArticleDetailState {
    private(set) var articleId: String!
    private(set) var articleDetail: ArticleModel?
    private(set) var fetchStockStatus: Bool = false
    private(set) var stockStatus: StockStatus?
    private(set) var stockUsers: UserListModel?
    private(set) var error: ApiError?
}

extension ArticleDetailState {
    mutating func update(articleId: String) {
        self.articleId = articleId
    }
    
    mutating func update(articleDetail: ArticleModel?) {
        self.articleDetail = articleDetail
    }
}

extension ArticleDetailState {
    func fetchTableSectionCount() -> Int {
        return articleDetail == nil ? 0 : 1
    }
    
    func fetchTableSectionRowCount() -> Int {
        return articleDetail == nil ? 0 : 2
    }
    
    func fetchArticleDetail() -> ArticleModel {
        return articleDetail ?? ArticleModel()
    }
    
    private func fetchStockCountDisplay() -> String {
        guard let users = stockUsers?.userModels else { return "0ストック" }
        return users.count >= 100 ? "ストック数: 100+" : "ストック数: \(users.count)"
    }
    
    func fetchArticleDetailTopInfo() -> (articleDetail: ArticleModel, stockCount: String, stockStatus: StockStatus) {
        let status = stockStatus ?? StockStatus(isStock: false)
        return (fetchArticleDetail(), fetchStockCountDisplay(), status)
    }
    
    func fetchHtmlBody() -> String {
        return articleDetail?.fetchRenderedBody() ?? ""
    }
}
