//
//  SFPulse.swift
//  Hostelworld
//
//  Created by Stefano Frosoni on 14/03/2016.
//  Copyright © 2016 Stefano Frosoni. All rights reserved.
//

import Foundation
import UIKit

class SFPulse: CAReplicatorLayer {
    
    fileprivate let originValueForRadius: Float = 0.0
    fileprivate let originValueForAlpha: Float = 0.45
    fileprivate let keyTimeForHalfOpacity:Float = 0.2
    fileprivate let useTimingFunction: Bool = true
    fileprivate var animationGroup: CAAnimationGroup = CAAnimationGroup()
    fileprivate var effect: CALayer = CALayer()
    fileprivate var numberOfLayers: Int = 1
    fileprivate var animationDuration: TimeInterval = 2.8
    fileprivate var pulseInterval: TimeInterval = 0.0
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    init(radius: CGFloat, position: CGPoint, numberOfLayers: Int, animationDuration: TimeInterval, pulseColor: UIColor) {
        super.init()
        backgroundColor = pulseColor.cgColor
        setupLayerWithColor(pulseColor)
        setupRadius(radius)
        setupNumberOfLayers(numberOfLayers)
        
        self.position = position
        self.animationDuration = animationDuration
        
        
        DispatchQueue.global(qos: .default).async(execute: { () -> Void in
            self.setupAnimationGroup()
            if self.pulseInterval != Double.infinity {
                DispatchQueue.main.async(execute: {
                    self.effect.add(self.animationGroup, forKey: "pulse")
                })
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLayerWithColor(_ color: UIColor) {
        self.effect = CALayer()
        self.effect.contentsScale = UIScreen.main.scale
        self.effect.opacity = 0
        self.effect.backgroundColor = color.cgColor
        self.addSublayer(self.effect)
    }
    
    func setupRadius(_ radius: CGFloat) {
        let diameter = radius * 2
        self.effect.bounds = CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter)
        self.effect.cornerRadius = radius
    }
    
    func setupNumberOfLayers(_ numberOfLayers: Int) {
        self.numberOfLayers = numberOfLayers
        self.instanceCount = numberOfLayers
        self.instanceDelay = (animationDuration + pulseInterval) / Double(numberOfLayers)
    }
    
    func setupAnimationGroup() {
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + pulseInterval
        animationGroup.repeatCount = Float.infinity
        animationGroup.isRemovedOnCompletion = false
        
        if useTimingFunction {
            let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            animationGroup.timingFunction = defaultCurve
        }
        
        animationGroup.animations = [scaleAnimation(), opacityAnimation()]
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: originValueForRadius as Float)
        scaleAnimation.toValue = NSNumber(value: 1.0 as Float)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func opacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [originValueForAlpha, 0.8, 0]
        opacityAnimation.keyTimes = [0, NSNumber(value: keyTimeForHalfOpacity), 1]
        opacityAnimation.isRemovedOnCompletion = false
        return opacityAnimation
    }
    
}
