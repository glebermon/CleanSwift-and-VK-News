//
//  NewsFeedCodeCell.swift
//  VKNews
//
//  Created by Глеб on 19.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

protocol NewsFeedCodeCellDelegate : class {
    func revealPost(for cell : NewsFeedCodeCell)
}

class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseID = "NewsFeedCodeCell"
    
    weak var delegate : NewsFeedCodeCellDelegate?
    
    // first layer
    let cardView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")//#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // second layer
    let topView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*
    let postLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
        return label
    }()
    */
    
    let postLabel : UITextView = {
       let txtView = UITextView()
        txtView.font = Constants.postLabelFont
        txtView.isScrollEnabled = false
        txtView.isSelectable = true
        txtView.isUserInteractionEnabled = true
        txtView.isEditable = false
        txtView.dataDetectorTypes = UIDataDetectorTypes.all
        txtView.backgroundColor = UIColor(named: "backgroundColor")
        
        let padding = txtView.textContainer.lineFragmentPadding
        txtView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        return txtView
    }()
    
    
    let moreTextButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(UIColor(named: "buttonsColor"), for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("View more", for: .normal)
        return button
    }()
    
    let gallaryCollectionView = GallaryCollectionView()
    
    let postImageView : WebImageView = {
        let image = WebImageView()
        image.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3098039216, blue: 0.3294117647, alpha: 1)
        return image
    }()
    
    let bottomView : UIView = {
        let view = UIView()
        return view
    }()
    
    // third layer on topView
    
    let iconImageView : WebImageView = {
        let icon = WebImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()
    
    let nameLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "textColor")
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5294117647, blue: 0.6, alpha: 1)
        return label
    }()
    
    // third layer on topView
    
    let likesView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // fourth layer on bottomView
    
    let likesImage : UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "likes")
        return img
    }()
    
    let commentsImage : UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "comments")
        return img
    }()
    
    let sharesImage : UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "shares")
        return img
    }()
    
    let viewsImage : UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "views")
        return img
    }()
    
    let likesLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lbl.text = "457K" // для теста. по завершении можно убрать
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    let commentsLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    let sharesLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    let viewsLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        
        overlayFirstLayer() // first layer
        overlaySecondLayer() // second layer
        overlayThidLayerOnTopView() // third layer on topView
        overlayThirdLayerOnBottomView() // third layer on bottomView
        overlayFourthLayerOnBottomViewViews() // fourth layer on bottomViewViews
        
    }
    
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
    func set(viewModel : FeedCellViewModel) {
        
        iconImageView.set(imageURL: viewModel.iconURLString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views

        postLabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
//        if let photoAttachement = viewModel.photoAttachment {
//            postImageView.set(imageURL: photoAttachement.photoURLString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
        
        if let photoAttachement = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachement.photoURLString)
            postImageView.isHidden = false
            gallaryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            gallaryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            gallaryCollectionView.isHidden = false
            gallaryCollectionView.set(photos: viewModel.photoAttachments)
        
        } else {
            postImageView.isHidden = true
            gallaryCollectionView.isHidden = true
        }
    }
    
    private func overlayFourthLayerOnBottomViewViews() {
        
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        helpInFourthLayer(view : likesView, img : likesImage, lbl: likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        helpInFourthLayer(view : commentsView, img : commentsImage, lbl: commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        helpInFourthLayer(view : sharesView, img : sharesImage, lbl: sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        helpInFourthLayer(view : viewsView, img : viewsImage, lbl: viewsLabel )
        
    }
    
    private func helpInFourthLayer(view : UIView, img : UIImageView, lbl: UILabel) {
        
        // imageView Constraints
        img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        img.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        img.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        // label Constraints
        lbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lbl.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 4).isActive = true
        lbl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    private func overlayThirdLayerOnBottomView() {
        
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likesView constraints
        
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth,
                                      height: Constants.bottomViewHeight))
        
        // commentsView constraints
        
        commentsView.anchor(top: bottomView.topAnchor,
                         leading: likesView.trailingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth,
                                      height: Constants.bottomViewHeight))
        
        // sharesView constraints
        
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          size: CGSize(width: Constants.bottomViewViewWidth,
                                       height: Constants.bottomViewHeight))
        
        // viewsView constraints
        
        viewsView.anchor(top: bottomView.topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: bottomView.trailingAnchor,
                          size: CGSize(width: Constants.bottomViewViewWidth,
                                       height: Constants.bottomViewHeight))
        
    }
    
    private func overlayThidLayerOnTopView() {
        
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // iconImageView constraints
        
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // nameLabel constraints
        
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
        // dateLabel constraints
        
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
    }
    
    private func overlaySecondLayer() {
        
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(gallaryCollectionView)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        // topView constraints
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // topView constraints
        //не нужны - расчитываются автоматически
        
        // postLabel constraints
        //не нужны - расчитываются автоматически
        
        // moreTextButton constraints
        //не нужны - расчитываются автоматически
        
        // postImageView constraints
        //не нужны - расчитываются автоматически
        
        // bottomView constraints
        //не нужны - расчитываются автоматически
    }
    
    private func overlayFirstLayer() {
        
        addSubview(cardView)
        
        // MARK: CardView Constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








/* как заполнить всю ячейку */
/*
cardView.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
*/

/* как сделать маленький квадра в нужной части ячейки */
/*
cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
cardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
cardView.widthAnchor.constraint(equalToConstant: 40).isActive = true
cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
*/

/* как разместить по центру одно ячейки */
/*
cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
*/

/* как заполнить половину ячейки сверху */
/*
cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
cardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
cardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
*/
