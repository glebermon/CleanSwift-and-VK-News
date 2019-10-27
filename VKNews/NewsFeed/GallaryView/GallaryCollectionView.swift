//
//  GallaryCollectionView.swift
//  VKNews
//
//  Created by Глеб on 21.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class GallaryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = UIColor(named: "backgroundColor")
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        register(GallaryCollectionViewCell.self, forCellWithReuseIdentifier: GallaryCollectionViewCell.reuseId)
        
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
    }
    
    func set(photos : [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = dequeueReusableCell(withReuseIdentifier: GallaryCollectionViewCell.reuseId, for: indexPath) as! GallaryCollectionViewCell
        cell.set(imageURL: photos[indexPath.row].photoURLString)
        return cell
    }
}

extension GallaryCollectionView : RowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        
        return CGSize(width: width, height: height)

    }
}
