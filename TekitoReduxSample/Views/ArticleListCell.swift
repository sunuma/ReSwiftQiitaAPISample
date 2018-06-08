//
//  ArticleListCell.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/08.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postedInfoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(article: ArticleModel) {
        postedInfoLabel.text = article.fetchPostedInfo()
        titleLabel.text = article.fetchArticleTitle()
        tagLabel.text = article.fetchTags()
        
        guard let downloadURL = article.fetchDownloadURL() else { return }
        //let resource = Resource(downloadURL: downloadURL, cacheKey: article.fetchId())
        //downloadProfileImage(resource)
    }
}
