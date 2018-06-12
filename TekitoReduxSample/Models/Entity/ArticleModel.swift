//
//  ArticleModel.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

struct ArticleModel: Decodable {
    private(set) var id: String?
    private(set) var isPrivate: Bool?
    private(set) var title: String?
    private(set) var body: String?
    private(set) var renderedBody: String?
    private(set) var url: String?
    private(set) var tags: [TagModel]?
    private(set) var user: UserModel?
    private(set) var coEditing: Bool?
    private(set) var createdAt: String?
    private(set) var updatedAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case isPrivate      = "private"
        case title
        case body
        case renderedBody   = "rendered_body"
        case url            = "url"
        case tags           = "tags"
        case user           = "user"
        case coEditing      = "coediting"
        case createdAt      = "created_at"
        case updatedAt      = "updated_at"
    }
}

extension ArticleModel: Equatable {
    static func ==(lhs: ArticleModel, rhs: ArticleModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ArticleModel {
    func fetchPostedInfo() -> String {
        guard let userId = user?.id else {
            return ""
        }
        return userId + " が投稿しました"
    }
    
    func fetchArticleTitle() -> String {
        return title ?? ""
    }
    
    func fetchDownloadURLString() -> String {
        return user?.profileImageUrl ?? ""
    }
    
    func fetchDownloadURL() -> URL? {
        return URL(string: fetchDownloadURLString())
    }
    
    func fetchTags() -> String {
        guard let tags = tags else {
            return ""
        }
        return tags.flatMap { $0.name }.joined(separator: ",")
    }
}
