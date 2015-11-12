//
//  Station.swift
//  NJIT Student Guide
//
//  Created by Ishani Chatterjee on 11/5/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import MapKit

class Station: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude:Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

