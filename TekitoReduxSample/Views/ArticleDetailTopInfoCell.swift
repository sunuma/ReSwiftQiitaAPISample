//
//  ArticleDetailTopInfoCell.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/18.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit
import ReSwift
import AlamofireImage

private extension Selector {
    static let stockButtonTapped = #selector(ArticleDetailTopInfoCell.stockButtonAction)
    static let userNameTapped = #selector(ArticleDetailTopInfoCell.tappedUserName)
}

class ArticleDetailTopInfoCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var postInfoLabel: UILabel!
    @IBOutlet weak var stockCountLabel: UILabel!
    @IBOutlet weak var stockButton: UIButton!
    var articleInfo: (articleDetail: ArticleModel, stockCount: String, stockStatus: StockStatus)?
    var selectedUserAction: ((_ userId: String) -> Void)?
    var updateStockButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stockButton.layer.cornerRadius = 4.0
        stockButton.addTarget(self, action: .stockButtonTapped, for: .touchUpInside)
        userNameButton.addTarget(self, action: .userNameTapped, for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func stockButtonAction() {
        updateStockButtonAction?()
    }
    
    @objc func tappedUserName() {
        guard let userId = articleInfo?.articleDetail.fetchUserId() else { return }
        selectedUserAction?(userId)
    }
    
    func update(info: (articleDetail: ArticleModel, stockCount: String, stockStatus: StockStatus)) {
        self.articleInfo = info
        updateCell()
    }
    
    func updateCell() {
        guard let articleInfo = articleInfo else { return }
        let article = articleInfo.articleDetail
        titleLabel.text = article.fetchArticleTitle()
        tagLabel.text = article.fetchTags()
        userNameButton.setTitle(article.fetchUserId(), for: .normal)
        postInfoLabel.text = " が投稿しました"
        stockCountLabel.text = articleInfo.stockCount
        updateStockButtonStatus(stockStatus: articleInfo.stockStatus)
        
        guard let url = article.fetchDownloadURL() else { return }
        self.profileImageView.af_setImage(withURL: url)
    }
    
    private func updateStockButtonStatus(stockStatus: StockStatus) {
        stockButton.setTitle(stockStatus.fetchStockStatusTitle(), for: .normal)
        stockButton.setTitleColor(stockStatus.fetchTextColor(), for: .normal)
        stockButton.backgroundColor = stockStatus.fetchBackgroundColor()
    }
}
