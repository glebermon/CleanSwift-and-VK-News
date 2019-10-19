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
        return Sizes(postLabelFrame: CGRect.zero, attachmentFrame: CGRect.zero)
    }
    
}
