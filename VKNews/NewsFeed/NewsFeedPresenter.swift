//
//  NewsFeedPresenter.swift
//  VKNews
//
//  Created by Глеб on 13.10.2019.
//  Copyright (c) 2019 Глеб. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    
    var feedCellLayoutCalculator : FeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    var dateFormater : DateFormatter {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }
  
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
            
        case .presentNewsFeed(let feed, let revealedPostIds):
            
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds)
            }
            
            
            let footerTitle = String.localizedStringWithFormat(NSLocalizedString("Newsfeed cells count", comment: ""), cells.count)
            let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
        case .presentFooterLoader:
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayFooterLoader)
        }
    }
    
    private func cellViewModel(from feedItem : FeedItem, profiles : [Profile], groups : [Group], revealedPostIds : [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
//        let photoAttachment = self.photoAttachmment(feedItem: feedItem) // для одной фотографии
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormater.string(from: date)
        let isFullSized = revealedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
//        let isFullSized = revealedPostIds.contains(feedItem.postId)
        let sizes = feedCellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "/b")
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconURLString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formattedCounter(counter: feedItem.likes?.count),
                                       comments: formattedCounter(counter: feedItem.comments?.count),
                                       shares: formattedCounter(counter: feedItem.reposts?.count),
                                       views: formattedCounter(counter: feedItem.views?.count),
                                       sizes: sizes,
                                       photoAttachments: photoAttachments)
    }
    
    private func formattedCounter (counter : Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterSrting = String(counter)
        
        if 4...6 ~= counterSrting.count {
            counterSrting = String(counterSrting.dropLast(3)) + "K"
        } else if counterSrting.count > 6 {
            counterSrting = String(counterSrting.dropLast(6)) + "М"
        }
        
        return counterSrting
    }
    
    private func profile(for sourceID : Int, profiles : [Profile], groups : [Group]) -> ProfileRepresentable {
        let profilesOrGroups : [ProfileRepresentable] = sourceID >= 0 ? profiles : groups
        let normalSourceId = sourceID >= 0 ? sourceID : -sourceID
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
    // данная функция для получения только одной фотографии
    private func photoAttachmment(feedItem : FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoURLString: firstPhoto.srcBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
    
    // функция, чтобы достать массив фотографий
    private func photoAttachments(feedItem : FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photos = attachment.photo else { return nil  }
            return FeedViewModel.FeedCellPhotoAttachment.init(photoURLString: photos.srcBIG,
                                                              width: photos.width,
                                                              height: photos.height)
        }
    }
  }
