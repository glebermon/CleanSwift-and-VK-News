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
        slider.maximumValue = 6
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
    
    let firstContainerView : UIView = {
        
        let contView : UIView = UIView()
        contView.translatesAutoresizingMaskIntoConstraints = false
//        contView.backgroundColor = .red
        return contView
    }()
    
    let secondContainerView : UIView = {
            
        let contView : UIView = UIView()
        contView.translatesAutoresizingMaskIntoConstraints = false
//           contView.backgroundColor = .red
        return contView
        }()
    
    
    lazy var firstStackView : UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [dice1])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 20
        sv.distribution = .fillEqually
        sv.alignment = .center
        return sv
    }()
    
    lazy var secondStackView : UIStackView = {
        
        let sv = UIStackView(/*arrangedSubviews: [dice4]*/)
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
        bt.titleLabel?.font = .systemFont(ofSize: 15)

        bt.layer.borderWidth = 2.0
        bt.layer.borderColor = UIColor.white.cgColor
        bt.layer.cornerRadius = 15.0

        bt.backgroundColor = UIColor.blue
        bt.setTitle("Roll", for: .normal)
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return bt
    }()
    
    var diceIndex = 0
    
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
//        dice1.widthAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
//        dice1.heightAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        dice2.image = UIImage(named: "dice1")
        dice3.image = UIImage(named: "dice1")
                
        view.addSubview(pointOfWillSlider)
        view.addSubview(firstContainerView)
        view.addSubview(secondContainerView)
        view.addSubview(pointOfWillSlider)
        view.addSubview(pointOfWillTextView)
        view.addSubview(changeImageButton)
        firstContainerView.addSubview(firstStackView)
        secondContainerView.addSubview(secondStackView)
        
        pointOfWillTextView.text = "Current point of will: \(Int(pointOfWillSlider.value))"
//        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        
        view.backgroundColor = .orange
        
        navigationController?.navigationBar.barTintColor = .orange
        title = "Test"
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        pointOfWillSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight + 25).isActive = true
        pointOfWillSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pointOfWillSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        pointOfWillSlider.widthAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
//        pointOfWillSlider.heightAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        
        pointOfWillTextView.topAnchor.constraint(equalTo: pointOfWillSlider.bottomAnchor, constant: 10).isActive = true
        pointOfWillTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        pointOfWillTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        
        firstContainerView.topAnchor.constraint(equalTo: pointOfWillTextView.bottomAnchor, constant: 20).isActive = true
        firstContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        firstContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        firstContainerView.heightAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        
        firstStackView.topAnchor.constraint(equalTo: firstContainerView.topAnchor, constant: 0).isActive = true
        firstStackView.leftAnchor.constraint(equalTo: firstContainerView.leftAnchor, constant: calculateCubeSide() / 3.5).isActive = true
        firstStackView.rightAnchor.constraint(equalTo: firstContainerView.rightAnchor, constant: -(calculateCubeSide() / 3.5)).isActive = true
        firstStackView.bottomAnchor.constraint(equalTo: firstContainerView.bottomAnchor, constant: 0).isActive = true
        
        secondContainerView.topAnchor.constraint(equalTo: firstContainerView.bottomAnchor, constant: 20).isActive = true
        secondContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        secondContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        secondContainerView.heightAnchor.constraint(equalToConstant: calculateCubeSide()).isActive = true
        
        secondStackView.topAnchor.constraint(equalTo: secondContainerView.topAnchor, constant: 0).isActive = true
        secondStackView.leftAnchor.constraint(equalTo: secondContainerView.leftAnchor, constant: calculateCubeSide() / 3).isActive = true
        secondStackView.rightAnchor.constraint(equalTo: secondContainerView.rightAnchor, constant: -(calculateCubeSide() / 3)).isActive = true
        secondStackView.bottomAnchor.constraint(equalTo: secondContainerView.bottomAnchor, constant: 0).isActive = true
        
        changeImageButton.topAnchor.constraint(equalTo: secondContainerView.bottomAnchor, constant: 30).isActive = true
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
        
        updateNumberOfDice(sender.value)
    }
    
    @objc func buttonAction(_ : UIButton) {
        
        rollDice()
        
    }
    
    private func calculateCubeSide() -> CGFloat {
        
        if view.frame.width > view.frame.height {
            return view.frame.height / 4
        } else {
            return view.frame.width / 4
        }
    }
    
    private func updateNumberOfDice(_ value : Float = 1) {
        
        if value >= 2 && value < 3 && firstStackView.arrangedSubviews.count < 2 {
            dice2.image = UIImage(named: "dice1")
            firstStackView.addArrangedSubview(dice2)
        } else if value >= 2 && value < 3 && firstStackView.arrangedSubviews.count > 2 {
            firstStackView.removeArrangedSubview(dice3)
            dice3.removeFromSuperview()
        } else if value >= 3 && firstStackView.arrangedSubviews.count < 3 {
            dice3.image = UIImage(named: "dice1")
            firstStackView.addArrangedSubview(dice3)
        } else if value < 2 && firstStackView.arrangedSubviews.count == 2 {
            firstStackView.removeArrangedSubview(dice2)
            dice2.removeFromSuperview()
        } else if value >= 4 && value < 5 && secondStackView.arrangedSubviews.count < 1 {
            dice4.image = UIImage(named: "dice1")
            secondStackView.addArrangedSubview(dice4)
        } else if value < 4 && secondStackView.arrangedSubviews.count >= 1 {
            secondStackView.removeArrangedSubview(dice4)
            dice4.removeFromSuperview()
        } else if value >= 5 && value < 6 && secondStackView.arrangedSubviews.count < 2 {
            dice5.image = UIImage(named: "dice1")
            secondStackView.addArrangedSubview(dice5)
        } else if value < 5 && value >= 4 && secondStackView.arrangedSubviews.count >= 2 {
            secondStackView.removeArrangedSubview(dice5)
            dice5.removeFromSuperview()
        }
        
    }
    
    private func rollDice() {
        
        for case let imageView as UIImageView in firstStackView.arrangedSubviews {
            diceIndex = Int(arc4random_uniform(6))
            imageView.image = UIImage(named: diceImageArray[diceIndex])
        }
        
        if secondStackView.arrangedSubviews.count > 0 {
            for case let imageView as UIImageView in secondStackView.arrangedSubviews {
                diceIndex = Int(arc4random_uniform(6))
                imageView.image = UIImage(named: diceImageArray[diceIndex])
            }
        }
        
    }
    

    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollDice()
        
    }
}

