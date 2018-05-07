//
//  myAnnotation.swift
//  Opgave 6
//
//  Created by Nickvde on 14/04/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title:String?) {
        self.coordinate = coordinate
        self.title = title
        
    }
}
