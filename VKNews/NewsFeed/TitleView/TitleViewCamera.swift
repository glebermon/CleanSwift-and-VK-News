//
//  TitleViewCamera.swift
//  VKNews
//
//  Created by Глеб on 29.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class TitleViewCamera : UIView {
    
    private var cameraButton : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .red
        img.clipsToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(cameraButton)
        makeConstraints()
    }
    
    func set(userViewModel : TitleViewViewModel) {
        if #available(iOS 13.0, *) {
            cameraButton.image = UIImage(systemName: "camera.fill")
        } else {
            cameraButton.image = UIImage(named: "search")
        }
    }
    
    private func makeConstraints() {
        
        // myAvatarView Constraints
        cameraButton.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 4, left: 777, bottom: 777, right: 4))
        cameraButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.cornerRadius = cameraButton.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
