//
//  MapAnnotation.swift
//  SFPulse
//
//  Created by Stefano Frosoni on 03/06/2016.
//  Copyright © 2016 Stefano Frosoni. All rights reserved.
//
import MapKit

open class MapAnnotation: NSObject, MKAnnotation {
    open var coordinate: CLLocationCoordinate2D
    open var title: String?

    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title

    }
}

