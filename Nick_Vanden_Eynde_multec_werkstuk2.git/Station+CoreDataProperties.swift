//
//  Station+CoreDataProperties.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var number: Int64
    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var latitude: Double

}
