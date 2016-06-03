//
//  MapAnnotation.swift
//  SFPulse
//
//  Created by Stefano Frosoni on 03/06/2016.
//  Copyright © 2016 Stefano Frosoni. All rights reserved.
//
import MapKit

public class MapAnnotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var title: String?

    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title

    }
}

