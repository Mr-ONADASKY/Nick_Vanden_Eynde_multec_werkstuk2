//
//  VilloStationManager.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 09/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import Foundation
import CoreLocation

private let singletonInstance = VilloStationManager()

class VilloStationManager : NSObject {
    
    class var sharedInstance: VilloStationManager { return singletonInstance }
    
    var villoStations = [VilloStationObject]()
    
    override init() {
        super.init()
        populateVilloStationList()
        
    }
    
    func populateVilloStationList() {
        
        villoStations = []
        let villoStationSFromDB = DataBaseManager().getDataFromTheDatabase()
        
        for villoStation in villoStationSFromDB {
            let number = villoStation.number
            let name = villoStation.name
            let address = villoStation.address
            let position = CLLocationCoordinate2DMake(villoStation.latitude, villoStation.longitude)
            let banking = villoStation.banking
            let bonus = villoStation.bonus
            let status = villoStation.status
            let contract_name = villoStation.contract_name
            let bike_stands = villoStation.bike_stands
            let available_bike_stands = villoStation.available_bike_stands
            let available_bikes = villoStation.available_bikes
            let last_update = villoStation.last_update
            
            let villoStationObject = VilloStationObject(number: Int(number), name: name!, address: address!, position: position, banking: banking, bonus: bonus, status: status!, contract_name: contract_name!, bike_stands: Int(bike_stands), available_bike_stands: Int(available_bike_stands), available_bikes: Int(available_bikes), last_update: last_update)
            
            villoStations.append(villoStationObject)
            
        }
    }

}
