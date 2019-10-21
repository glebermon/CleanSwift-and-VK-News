//
//  NewsFeedModels.swift
//  VKNews
//
//  Created by Глеб on 13.10.2019.
//  Copyright (c) 2019 Глеб. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case revealPostIds(postID : Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed : FeedResponse, revealedPostIds : [Int])
        
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel : FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
    struct Cell : FeedCellViewModel {
        
        var postId : Int
        
        var iconURLString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        var sizes: FeedCellSizes
        
    }
    
    struct FeedCellPhotoAttachment : FeedCellPhotoAttachmentViewModel {
        
        var photoURLString: String?
        var width: Int
        var height: Int
        
    }
    
    let cells : [Cell]
}
