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
        case getUser
        case revealPostIds(postID : Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed : FeedResponse, revealedPostIds : [Int])
        case presentUserInfo(user : UserResponse?)
        
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel : FeedViewModel)
        case displayUser(userViewModel : UserViewModel)
      }
    }
  }
}

struct UserViewModel : TitleViewViewModel {
    var photoUrlString: String?
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
        var sizes: FeedCellSizes
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
//        var photoAttachment: FeedCellPhotoAttachmentViewModel?
    }
    
    struct FeedCellPhotoAttachment : FeedCellPhotoAttachmentViewModel {
        
        var photoURLString: String?
        var width: Int
        var height: Int
        
    }
    
    let cells : [Cell]
}
