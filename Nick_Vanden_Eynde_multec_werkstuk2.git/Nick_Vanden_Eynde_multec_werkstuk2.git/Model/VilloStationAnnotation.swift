//
//  VilloStationAnnotation.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 09/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import Foundation
import MapKit

class VilloStationAnnotation: NSObject, MKAnnotation {
    var villoStationObject: VilloStationObject
    var coordinate: CLLocationCoordinate2D { return villoStationObject.position}
    
    init(villoStationObject: VilloStationObject) {
        self.villoStationObject = villoStationObject
        super.init()
    }
    
    var title: String? {
        return villoStationObject.name
    }
    
    var available_bike_stands: String? {
        return String(villoStationObject.available_bike_stands)
    }
    
    var available_bikes: String? {
        return String(villoStationObject.available_bikes)
    }
}
