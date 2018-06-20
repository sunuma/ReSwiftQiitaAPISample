//
//  ArticleListModel.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

struct ArticleListModel: Decodable {
    var articleModels: [ArticleModel]?
}

extension ArticleListModel {
    init(from decoder: Decoder) {
        var list: [ArticleModel] = []
        do {
            var unkeyedContainer = try decoder.unkeyedContainer()
            while !unkeyedContainer.isAtEnd {
                let article = try unkeyedContainer.decode(ArticleModel.self)
                list.append(article)
            }
        } catch {
            appPrint("ArticleListModel initialize error = \(error.localizedDescription)")
        }
        self.init(articleModels: list)
    }
}
