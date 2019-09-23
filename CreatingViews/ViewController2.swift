//
//  ViewController2.swift
//  CreatingViews
//
//  Created by Глеб on 22/09/2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    let pointOfWillSlider : UISlider = {
        
        let slider : UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        slider.value = 1
        slider.minimumValue = 1
        slider.maximumValue = 3
        return slider
        
    }()
    
    let pointOfWillTextView : UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.backgroundColor = .orange
        textView.textAlignment = .center
        return textView
        
    }()
    
    let containerView : UIView = {
        
        let contView : UIView = UIView()
        contView.translatesAutoresizingMaskIntoConstraints = false
        contView.backgroundColor = .red
        return contView
    }()
    
    
    lazy var stackView : UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [dice1])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 20
        sv.distribution = .fillEqually
        sv.alignment = .center
        return sv
    }()
    
    let changeImageButton : UIButton = {
       
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.setTitleColor(UIColor.gray, for: .highlighted)
        bt.titleLabel?.font = .systemFont(ofSize: 30)

        bt.layer.borderWidth = 2.0
        bt.layer.borderColor = UIColor.white.cgColor
        bt.layer.cornerRadius = 15.0

        bt.backgroundColor = UIColor.blue
        bt.setTitle("Roll", for: .normal)
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return bt
    }()
    
    let diceIndex = 0
    
    let diceImageArray : Array = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    let dice1 : UIImageView = UIImageView()
    let dice2 : UIImageView = UIImageView()
    let dice3 : UIImageView = UIImageView()
    let dice4 : UIImageView = UIImageView()
    let dice5 : UIImageView = UIImageView()
    let dice6 : UIImageView = UIImageView()
    
    var diceArray : [UIImageView] = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diceArray = [dice1, dice2, dice3, dice4, dice5, dice6]
        dice1.image = UIImage(named: "dice1")
        dice1.widthAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        dice1.heightAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        dice2.image = UIImage(named: "dice1")
        dice3.image = UIImage(named: "dice1")
                
        view.addSubview(pointOfWillSlider)
        view.addSubview(containerView)
        view.addSubview(pointOfWillSlider)
        view.addSubview(pointOfWillTextView)
        view.addSubview(changeImageButton)
        containerView.addSubview(stackView)
        
        pointOfWillTextView.text = "Number of image: \(Int(pointOfWillSlider.value))"
//        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        
        view.backgroundColor = .orange
        
        navigationController?.navigationBar.barTintColor = .orange
        title = "Test"
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        pointOfWillSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight + 25).isActive = true
        pointOfWillSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        pointOfWillSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
//        pointOfWillSlider.widthAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
//        pointOfWillSlider.heightAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        
        pointOfWillTextView.topAnchor.constraint(equalTo: pointOfWillSlider.bottomAnchor, constant: 10).isActive = true
        pointOfWillTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        pointOfWillTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        
        containerView.topAnchor.constraint(equalTo: pointOfWillTextView.bottomAnchor, constant: 20).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: calculateCubeSide() / 3).isActive = true
        stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -(calculateCubeSide() / 3)).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        
        changeImageButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
        changeImageButton.widthAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        changeImageButton.heightAnchor.constraint(equalToConstant: calculateCubeSide()/2).isActive = true
        changeImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        for i in 0..<diceArray.count {
            diceArray[i].contentMode = .scaleAspectFit
            diceArray[i].image = UIImage(named: "dice1")
        }
        
    }
    
    @objc private func changeValue(sender : UISlider) {
        
        pointOfWillTextView.text = "Current point of will: \(Int(pointOfWillSlider.value))"
        
        if sender.value >= 2 && sender.value < 3 {
            dice2.image = UIImage(named: "dice1")
            stackView.addArrangedSubview(dice2)
        } else if sender.value >= 3{
            dice3.image = UIImage(named: "dice1")
            stackView.addArrangedSubview(dice3)
        }
    }
    
    private func calculateCubeSide() -> CGFloat {
        
        if view.frame.width > view.frame.height {
            return view.frame.height / 4
        } else {
            return view.frame.width / 4
        }
    }
    
    @objc func buttonAction(_ : UIButton) {
        
    }
}
