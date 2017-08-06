//
//  FloatingActionButton.swift
//  Timeline
//
//  Created by Gabriel Morales on 8/6/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

@IBDesignable
class FloatingActionButton: UIButton {
    
    var shadowView: UIView!
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        
        if shadowView == nil && shadowOpacity > 0 {
            shadowView = UIView(frame: self.frame)
            shadowView.backgroundColor = UIColor.clear
            shadowView.layer.shadowColor = shadowColor.cgColor
            shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
            shadowView.layer.shadowOffset = shadowOffset
            shadowView.layer.shadowOpacity = Float(shadowOpacity)
            shadowView.layer.shadowRadius = shadowRadius
            shadowView.layer.masksToBounds = true
            shadowView.clipsToBounds = false
            
            self.superview?.addSubview(shadowView)
            self.superview?.bringSubview(toFront: self)
        }
    }
    
    
    /// Begin Button Touch Tracking
    ///
    /// - Parameters:
    ///   - touch: An object representing the location, size, movement, and force of a touch occuring on the screen.
    ///   - event: An object that describes a single user interaction with your app.
    /// - Returns: A value type whose instances are either true or false.
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        UIView.animate(withDuration: 0.2) {
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
                self.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) /* #92003B */
            } else {
                self.transform = .identity
                self.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) /* #CE0755 */
            }
        }
        return true
    }
    
    
    /// End Button Touch Tracking
    ///
    /// - Parameters:
    ///   - touch: An object representing the location, size, movement, and force of a touch occuring on the screen.
    ///   - event: An object that describes a single user interaction with your app.
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 1
        })
    }
    
    
    /// Border Inspctables
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    /// Shaddow Inspectables
    @IBInspectable public var shadowOpacity: CGFloat = 0
    @IBInspectable public var shadowColor: UIColor = UIColor.clear
    @IBInspectable public var shadowRadius: CGFloat = 0
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 0)
}
