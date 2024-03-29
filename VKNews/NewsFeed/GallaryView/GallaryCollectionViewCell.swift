//
//  GallaryCollectionViewCell.swift
//  VKNews
//
//  Created by Глеб on 21.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class GallaryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "gallaryCell"
    
    let myImageView : WebImageView = {
        let img = WebImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myImageView)
        
        // myImageView costraints
        myImageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageURL : String?) {
        myImageView.set(imageURL : imageURL)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
