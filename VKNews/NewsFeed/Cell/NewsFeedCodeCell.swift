//
//  NewsFeedCodeCell.swift
//  VKNews
//
//  Created by Глеб on 19.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseID = "NewsFeedCodeCell"
    
    
    // first layer
    let cardView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // second layer
    let topView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return view
    }()
    
    let postLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
        return label
    }()
    
    let postImageView : WebImageView = {
        let image = WebImageView()
        image.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return image
    }()
    
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return view
    }()
    
    // third layer on topView
    
    let iconImageView : WebImageView = {
        let icon = WebImageView()
        icon.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()
    
    let nameLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5294117647, blue: 0.6, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return label
    }()
    
    // third layer on topView
    
    let likesView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return view
    }()
    
    let commentsView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return view
    }()
    
    let sharesView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return view
    }()
    
    let viewsView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
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
    
    /*  @IBOutlet weak var cardView: UIView!
       @IBOutlet weak var iconImageView: WebImageView!
       @IBOutlet weak var nameLabel: UILabel!
       @IBOutlet weak var dateLabel: UILabel!
       @IBOutlet weak var postLabel: UILabel!
       @IBOutlet weak var postImageView: WebImageView!
       @IBOutlet weak var likesLabel: UILabel!
       @IBOutlet weak var commentsLabel: UILabel!
       @IBOutlet weak var sharesLabel: UILabel!
       @IBOutlet weak var viewsLabel: UILabel!
       @IBOutlet weak var bottomView: UIView! */
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        overlayFirstLayer() // first layer
        overlaySecondLayer() // second layer
        overlayThidLayerOnTopView() // third layer on topView
        overlayThidLayerOnBottomView() // third layer on bottomView
        
    }
    
    func set(viewModel : FeedCellViewModel) {

        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachement = viewModel.photoAttachment {
//            postImageView.set(imageURL: photoAttachement.photoURLString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
    }
    
    private func overlayThidLayerOnBottomView() {
        
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
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        // topView constraints
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // topView constraints
        
        // postLabel constraints
        
        // postImageView constraints
        
        // bottomView constraints
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
