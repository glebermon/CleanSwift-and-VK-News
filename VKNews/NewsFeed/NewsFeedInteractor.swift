//
//  NewsFeedInteractor.swift
//  VKNews
//
//  Created by Глеб on 13.10.2019.
//  Copyright (c) 2019 Глеб. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?

  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    switch request {

    case .getNewsFeed:
        service?.getFeed(completion: { [weak self] (revealdPostIds, feed) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostIds: revealdPostIds))
        })
    case .getUser:
        service?.getUser(completion: { [weak self] (user) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: user))
        })
    case .revealPostIds(let postID):
        service?.revealedPostIds(forPostId: postID, completion: { [weak self] (revealdPostIds, feed) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostIds: revealdPostIds))
        })
    case .getNextBatch:
        self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentFooterLoader)
        service?.getNextBatch(completion: { [weak self] (revealdPostIds, feed) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostIds: revealdPostIds))
        })
    }
  }
}
