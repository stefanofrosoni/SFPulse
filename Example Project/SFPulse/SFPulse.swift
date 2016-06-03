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
    
    private let originValueForRadius: Float = 0.0
    private let originValueForAlpha: Float = 0.45
    private let keyTimeForHalfOpacity:Float = 0.2
    private let useTimingFunction: Bool = true
    private var animationGroup: CAAnimationGroup = CAAnimationGroup()
    private var effect: CALayer = CALayer()
    private var numberOfLayers: Int = 1
    private var animationDuration: NSTimeInterval = 2.8
    private var pulseInterval: NSTimeInterval = 0.0
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
    }
    
    init(radius: CGFloat, position: CGPoint, numberOfLayers: Int, animationDuration: NSTimeInterval, pulseColor: UIColor) {
        super.init()
        backgroundColor = pulseColor.CGColor
        setupLayerWithColor(pulseColor)
        setupRadius(radius)
        setupNumberOfLayers(numberOfLayers)
        
        self.position = position
        self.animationDuration = animationDuration
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            self.setupAnimationGroup()
            if self.pulseInterval != Double.infinity {
                dispatch_async(dispatch_get_main_queue(), {
                    self.effect.addAnimation(self.animationGroup, forKey: "pulse")
                })
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLayerWithColor(color: UIColor) {
        self.effect = CALayer()
        self.effect.contentsScale = UIScreen.mainScreen().scale
        self.effect.opacity = 0
        self.effect.backgroundColor = color.CGColor
        self.addSublayer(self.effect)
    }
    
    func setupRadius(radius: CGFloat) {
        let diameter = radius * 2
        self.effect.bounds = CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter)
        self.effect.cornerRadius = radius
    }
    
    func setupNumberOfLayers(numberOfLayers: Int) {
        self.numberOfLayers = numberOfLayers
        self.instanceCount = numberOfLayers
        self.instanceDelay = (animationDuration + pulseInterval) / Double(numberOfLayers)
    }
    
    func setupAnimationGroup() {
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + pulseInterval
        animationGroup.repeatCount = Float.infinity
        animationGroup.removedOnCompletion = false
        
        if useTimingFunction {
            let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            animationGroup.timingFunction = defaultCurve
        }
        
        animationGroup.animations = [scaleAnimation(), opacityAnimation()]
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(float: originValueForRadius)
        scaleAnimation.toValue = NSNumber(float: 1.0)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func opacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [originValueForAlpha, 0.8, 0]
        opacityAnimation.keyTimes = [0, keyTimeForHalfOpacity, 1]
        opacityAnimation.removedOnCompletion = false
        return opacityAnimation
    }
    
}