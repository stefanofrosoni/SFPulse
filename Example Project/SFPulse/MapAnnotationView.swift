//
//  MapAnnotationView.swift
//  SFPulse
//
//  Created by Stefano Frosoni on 03/06/2016.
//  Copyright © 2016 Stefano Frosoni. All rights reserved.
//
import MapKit

class MapAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func configureView() {
        backgroundColor = .clearColor()
        let circlesize: Double = 8.0
        let circleView = UIView(frame: CGRect(x: -circlesize/2, y: -circlesize/2, width: circlesize, height: circlesize))
        circleView.center = center
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
        circleView.backgroundColor = UIColor.orangeColor()
        addSubview(circleView)

        let sfPulse = SFPulse(radius: 80, position: circleView.center, numberOfLayers: 2, animationDuration: 4.0, pulseColor: .orangeColor())
        layer.insertSublayer(sfPulse, below: circleView.layer)

        UIView.animateWithDuration(1.2, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: [], animations: {
            circleView.transform = CGAffineTransformMakeScale(2, 2)
            }, completion: nil)
    }

    static var identifier: String {
        return "MapAnnotationView"
    }
    
}

