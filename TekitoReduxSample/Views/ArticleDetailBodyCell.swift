//
//  ArticleDetailBodyCell.swift
//  TekitoReduxSample
//
//  Created by Shin Unuma on 2018/06/18.
//  Copyright © 2018年 Shin Unuma. All rights reserved.
//

import UIKit

class ArticleDetailBodyCell: UITableViewCell {
    @IBOutlet weak var htmlWebView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        htmlWebView.scrollView.isScrollEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadRenderHtmlBody(html: String) {
        htmlWebView.loadHTMLString(html, baseURL: nil)
    }
}
