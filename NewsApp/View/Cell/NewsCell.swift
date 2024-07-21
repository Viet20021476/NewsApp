//
//  NewsCell.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    private var imageTask: Task<Void, Never>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        newsImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupData(news: News) {
        self.titleLabel.text = news.title
        self.descriptionLabel.text = news.description
        self.dateLabel.text = news.publishedAt.convertToFormattedString()
        self.categoryLabel.text = news.category
        self.sourceLabel.text = news.source
        
        if let imageUrlString = news.image, let imageUrl = URL(string: imageUrlString) {
            imageTask = Task {
                await newsImageView.setImage(from: imageUrl)
            }
        } else {
            newsImageView.image = UIImage(named: "news_placeholder")
        }
    }
    
}
