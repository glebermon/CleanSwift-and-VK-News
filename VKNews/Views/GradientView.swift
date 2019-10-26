//
//  GradientView.swift
//  VKNews
//
//  Created by Глеб on 26.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable private var startColor : UIColor? {
        didSet {
            setupGradientColord()
        }
    }
    @IBInspectable private var endColor : UIColor? {
        didSet {
            setupGradientColord()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColord()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func setupGradientColord() {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}
