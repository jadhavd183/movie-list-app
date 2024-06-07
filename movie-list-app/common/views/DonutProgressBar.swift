//
//  DonutProgressBar.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import UIKit

class DonutProgressBar: UIView {
    
    private let shapeLayer = CAShapeLayer()
    private let progressLabel = UILabel()
    
    var progress: CGFloat = 0 {
        didSet {
            if progress > 0.7 {
                progressColor = UIColor(hex: "6eff00")
            }else if progress > 0.5 {
                progressColor = UIColor(hex: "ffdd00")
            }else {
                progressColor = .orange
            }
            setNeedsLayout()
        }
    }
    
    var progressColor: UIColor = .blue {
        didSet {
            shapeLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor: UIColor = .clear {
        didSet {
            shapeLayer.fillColor = trackColor.cgColor
        }
    }
    
    var lineWidth: CGFloat = 10 {
        didSet {
            shapeLayer.lineWidth = lineWidth
        }
    }
    
    var font: UIFont = UIFont.systemFont(ofSize: 20) {
        didSet {
            progressLabel.font = font
        }
    }
    
    var textColor: UIColor = .black {
        didSet {
            progressLabel.textColor = textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        progressLabel.textAlignment = .center
        addSubview(progressLabel)
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = trackColor.cgColor
        shapeLayer.strokeColor = progressColor.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi * progress
        
        shapeLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        
        progressLabel.frame = bounds
        progressLabel.text = "\(Int(progress * 100))%"
    }
}
