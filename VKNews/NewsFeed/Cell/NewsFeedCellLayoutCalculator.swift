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
    var moreTextButtonFrame: CGRect
    
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText : String?, photoAttachment : FeedCellPhotoAttachmentViewModel?, isFullSizedPost : Bool) -> FeedCellSizes
}


final class NewsFeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
        
    private var screenWidth : CGFloat
    
    init(screenWidth : CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    

    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?, isFullSizedPost : Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: Работа с PostLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelsInsets.left, y: Constants.postLabelsInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelsInsets.right - Constants.postLabelsInsets.left
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
            
        }
        
        // MARK: Работа с moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        // MARK: Работа с attachmentFrame
        
        let attachementTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelsInsets.top : moreTextButtonFrame.maxY + Constants.postLabelsInsets.bottom
        
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
                     totalHeight: totalHeight,
                     moreTextButtonFrame: moreTextButtonFrame)
    }
    
}
