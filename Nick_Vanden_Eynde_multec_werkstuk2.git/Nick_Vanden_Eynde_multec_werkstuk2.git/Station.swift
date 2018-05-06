//
//  Station.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import Foundation
import CoreLocation
class stationaa{
    var number:Int
    var name:String
    var address: String
    var position:CLLocationCoordinate2D
    var banking:BooleanLiteralType
    var bonus:BooleanLiteralType
    var status:String
    var contract_name:String
    var bike_stands:Int
    var available_bike_stands:Int
    var available_bikes:Int
    var last_update:Double

    public init(number: Int, name: String, address: String, position: CLLocationCoordinate2D, banking: BooleanLiteralType, bonus: BooleanLiteralType, status: String, contract_name: String, bike_stands: Int, available_bike_stands: Int, available_bikes: Int, last_update: Double) {
        self.number = number
        self.name = name
        self.address = address
        self.position = position
        self.banking = banking
        self.bonus = bonus
        self.status = status
        self.contract_name = contract_name
        self.bike_stands = bike_stands
        self.available_bike_stands = available_bike_stands
        self.available_bikes = available_bikes
        self.last_update = last_update
    }
    


}
