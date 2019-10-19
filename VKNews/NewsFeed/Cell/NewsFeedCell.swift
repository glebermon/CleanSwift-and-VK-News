//
//  NewsFeedCell.swift
//  VKNews
//
//  Created by Глеб on 14.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
    var iconURLString : String { get }
    var name : String { get }
    var date : String { get }
    var text : String? { get }
    var likes : String? { get }
    var comments : String? { get }
    var shares : String? { get }
    var views : String? { get }
    var photoAttachment : FeedCellPhotoAttachmentViewModel? { get }
    
    var sizes : FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame : CGRect { get }
    var attachmentFrame : CGRect { get }
    
    var bottomViewFrame: CGRect { get }
    var totalHeight : CGFloat { get } 
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoURLString : String? { get }
    var width : Int { get }
    var height : Int { get }
}

class NewsFeedCell: UITableViewCell {
        
    static let reuseID = "NewsFeedCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    
    /*Данный метод для того, чтобы при быстром просмотре ленты ячейки очищались для переиспользования*/
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        postLabel.textColor = .black
        
        backgroundColor = .clear
        selectionStyle = .none
        
    }
    
    func set(viewModel : FeedCellViewModel) {
        
        iconImageView.set(imageURL: viewModel.iconURLString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachement = viewModel.photoAttachment {
            postImageView.set(imageURL: photoAttachement.photoURLString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
    }
}
