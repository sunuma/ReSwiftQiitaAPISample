//
//  TagModel.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/05.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import Foundation

struct TagModel: Decodable {
    var name: String?
    var versions: [String]?
}
