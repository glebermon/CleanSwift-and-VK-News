//
//  ViewController.swift
//  CreatingViews
//
//  Created by Глеб on 20/09/2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit




class ViewController: UIViewController {

    var imageView = UIImageView()

    var buttonPressed = UIButton.init(type: .custom)

    var firstRandomIndex = 0

    var diceArray : Array = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let xAxis = self.view.frame.width / 2

        let yAxis = self.view.frame.height / 2




        let cubeSide : CGFloat = self.view.frame.width / 4

        let spaceBetweenCubes : CGFloat = cubeSide / 4

//        imageView = UIImageView(frame: CGRect(x: xAxis - (viewWidth / 2), y: yAxis - (viewHeight / 2), width: viewWidth, height: viewHeight))
//
//        imageView.image = UIImage(named: "dice1")
//
//        self.view.addSubview(imageView)


        let image1 = UIImageView(frame: CGRect(x: xAxis - (cubeSide / 2), y: yAxis - cubeSide - (spaceBetweenCubes / 2), width: cubeSide, height: cubeSide))
        let image2 = UIImageView(frame: CGRect(x: xAxis - (cubeSide / 2), y: yAxis + (spaceBetweenCubes / 2), width: cubeSide, height: cubeSide))
        let image3 = UIImageView(frame: CGRect(x: xAxis - (cubeSide / 2) - spaceBetweenCubes - cubeSide, y: yAxis - cubeSide - (spaceBetweenCubes / 2), width: cubeSide, height: cubeSide))
        let image4 = UIImageView(frame: CGRect(x: xAxis - (cubeSide / 2) - spaceBetweenCubes - cubeSide, y: yAxis + (spaceBetweenCubes / 2), width: cubeSide, height: cubeSide))
        let image5 = UIImageView(frame: CGRect(x: xAxis + (cubeSide / 2) + spaceBetweenCubes, y: yAxis - cubeSide - (spaceBetweenCubes / 2), width: cubeSide, height: cubeSide))
        let image6 = UIImageView(frame: CGRect(x: xAxis + (cubeSide / 2) + spaceBetweenCubes, y: yAxis + (spaceBetweenCubes / 2), width: cubeSide, height: cubeSide))

        image1.image = UIImage(named: "dice1")
        image2.image = UIImage(named: "dice1")
        image3.image = UIImage(named: "dice1")
        image4.image = UIImage(named: "dice1")
        image5.image = UIImage(named: "dice1")
        image6.image = UIImage(named: "dice1")

        self.view.addSubview(image1)
        self.view.addSubview(image2)
        self.view.addSubview(image3)
        self.view.addSubview(image4)
        self.view.addSubview(image5)
        self.view.addSubview(image6)



        buttonPressed = UIButton(frame: CGRect(x: xAxis - (cubeSide / 2), y: yAxis + cubeSide * 1.5, width: cubeSide, height: cubeSide / 2))
        buttonPressed.setTitleColor(UIColor.white, for: .normal)
        buttonPressed.setTitleColor(UIColor.gray, for: .highlighted)
        buttonPressed.titleLabel?.font = .systemFont(ofSize: 30)

        buttonPressed.layer.borderWidth = 2.0
        buttonPressed.layer.borderColor = UIColor.white.cgColor
        buttonPressed.layer.cornerRadius = 15.0

        buttonPressed.backgroundColor = UIColor.blue
        buttonPressed.setTitle("Roll", for: .normal)
        buttonPressed.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(buttonPressed)


    }

    @objc func buttonAction(sender : UIButton!) {

        firstRandomIndex = Int(arc4random_uniform(6))
        imageView.image = UIImage(named: diceArray[firstRandomIndex])

        print("tapped")

    }
}
