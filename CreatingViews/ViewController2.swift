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
        slider.maximumValue = 20
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pointOfWillSlider)
        view.addSubview(containerView)
        view.addSubview(pointOfWillSlider)
        view.addSubview(pointOfWillTextView)
        
        pointOfWillTextView.text = "Current point of will: \(Int(pointOfWillSlider.value))"
//        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        
        view.backgroundColor = .orange
        
        navigationController?.navigationBar.barTintColor = .orange
        title = "Andor"
        
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
        
    }
    
    @objc private func changeValue(_ : UISlider) {
        
        pointOfWillTextView.text = "Current point of will: \(Int(pointOfWillSlider.value))"
        
    }
    
    private func calculateCubeSide() -> CGFloat {
        
        if view.frame.width > view.frame.height {
            return view.frame.height / 4
        } else {
            return view.frame.width / 4
        }
    }
}
