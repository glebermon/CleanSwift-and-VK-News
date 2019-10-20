//
//  NewsFeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by Глеб on 18.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

struct Sizes : FeedCellSizes {
    
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText : String?, photoAttachment : FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}


final class NewsFeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
        
    private var screenWidth : CGFloat
    
    init(screenWidth : CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    

    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: Работа с PostLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelsInsets.left, y: Constants.postLabelsInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelsInsets.right - Constants.postLabelsInsets.left
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Работа с attachmentFrame
        
        let attachementTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelsInsets.top : postLabelFrame.maxY + Constants.postLabelsInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachementTop),
                                     size: CGSize.zero)
        
        if let attachment = photoAttachment {
            let photoHeight : Float = Float(attachment.height)
            let photowidth : Float = Float(attachment.width)
            let ratio : CGFloat = CGFloat(photoHeight / photowidth)
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        // MARK: Работа с bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        // MARK: Total Height
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
}
