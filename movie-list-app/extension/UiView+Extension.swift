//
//  UiView+Constraints+Extension.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import UIKit

extension UIView {
    // MARK: - Edge Constraints
    
    @discardableResult
    func edgesToSuperview(insets: UIEdgeInsets = .zero) -> Self {
        guard let superview = superview else {
            fatalError("Superview not found. Make sure the view is added to a superview before calling this method.")
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
        ])
        return self
    }
    
    // MARK: - Center Constraints
    
    @discardableResult
    func centerInSuperview() -> Self {
        guard let superview = superview else {
            fatalError("Superview not found. Make sure the view is added to a superview before calling this method.")
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
        return self
    }
    
    // MARK: - Size Constraints
    
    @discardableResult
    func setSize(_ size: CGSize) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ])
        return self
    }
    
    @discardableResult
    func setSize(height: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
        return self
    }
    
    func setSize(	width: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width)
        ])
        return self
    }
    
    // MARK: - Aspect Ratio Constraint
    
    @discardableResult
    func setAspectRatio(_ ratio: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio)
        ])
        return self
    }
    
    // MARK: - Add Corner Radius
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    static func buildSpaceView(size: CGSize) -> UIView {
        let v = UIView()
        v.setSize(size)
        return v
    }
}

