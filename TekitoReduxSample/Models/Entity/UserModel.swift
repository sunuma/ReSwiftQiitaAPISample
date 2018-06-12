//
//  UserModel.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

class UserModel: Decodable {
    var permanentId: Int?
    var id: String?
    var name: String?
    var location: String?
    var profileImageUrl: String?
    var twitterScreenName: String?
    var facebookId: String?
    var linkedInId: String?
    var githubAccountName: String?
    var itemsCount: Int?
    var followeesCount: Int?
    var followersCount: Int?
    var organization: String?
    var websiteUrl: String?
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case permanentId        = "permanent_id"
        case id
        case name
        case location
        case profileImageUrl    = "profile_image_url"
        case twitterScreenName  = "twitter_screen_name"
        case facebookId         = "facebook_id"
        case linkedInId         = "linkedin_id"
        case githubAccountName  = "github_login_name"
        case itemsCount         = "items_count"
        case followeesCount     = "followees_count"
        case followersCount     = "followers_count"
        case organization
        case websiteUrl         = "website_url"
        case description
    }
}

extension UserModel {
    func fetchUserName() -> String {
        return name ?? ""
    }
}
