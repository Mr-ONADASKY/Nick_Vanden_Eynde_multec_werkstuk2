//
//  DataBaseManager.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 06/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import Foundation
import CoreData
import UIKit
 final class  DataBaseManager{
   func getDataFromTheDatabase() -> [Station]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
            else {
                fatalError()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let stationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Station")
        
        let villoStations: [Station]
        do {
            villoStations =
            try managedContext.fetch(stationFetch) as! [Station]
            return villoStations
        }
        catch {
            fatalError()
        }
    }
    
    func updateDatabase(stations: [AnyObject]){
        ClearDataBase()
        insertInDataBase(stations: stations)

}
    private func ClearDataBase() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let stationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Station")
        
        let stations:[Station]
        
        do {
            stations = try managedContext.fetch(stationFetch) as! [Station]
            
            for station in stations {
                managedContext.delete(station)
                
                try! managedContext.save()
            }
            
        } catch {
            fatalError("Failed to fetch stations: \(error)")
        }
    }
    
    private func insertInDataBase(stations: [AnyObject]){
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
                else {
                    return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            for station in stations {
                let villoStation = NSEntityDescription.insertNewObject(forEntityName: "Station", into: managedContext) as! Station
                
                villoStation.number = station["number"] as! Int64
                villoStation.name = station["name"] as? String
                villoStation.address = station["address"] as? String
                let coordinateJSON = station["position"] as? [String: Double]
                villoStation.latitude = coordinateJSON!["lat"]!
                villoStation.longitude = coordinateJSON!["lng"]!
                villoStation.banking = (station["banking"] != nil)
                villoStation.bonus = (station["bonus"] != nil)
                villoStation.status = station["status"] as? String
                villoStation.contract_name = station["contract_name"] as? String
                villoStation.bike_stands = station["bike_stands"] as? String
                villoStation.available_bike_stands = station["available_bike_stands"] as! Int64
                villoStation.available_bikes = station["available_bikes"] as! Int64
                villoStation.last_update = station["last_update"] as! Double
                
                do {
                    try managedContext.save()
                    updateUpdateTime()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
        
        
        }
    
     func getUpdateTime() -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                fatalError()
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let timeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UpdateTime")
        
        
        let opgehaaldeTime: [UpdateTime]
        
        do {
            opgehaaldeTime = try managedContext.fetch(timeFetch) as! [UpdateTime]
            if opgehaaldeTime.first != nil{
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "nl_BE POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600)
                return dateFormatter.string(from: opgehaaldeTime.first!.time!)
            }else {
                return "Pull down to get data"
            }
            
  
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    private func updateUpdateTime(){
        removeUpdatetime()
        createDate()
        
        
    }
    
    private func createDate() {
        let currentDateTime = Date()
    
        insertUpdateTime(currentDateTime: currentDateTime)
    }
    
    private func insertUpdateTime(currentDateTime: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let time = NSEntityDescription.insertNewObject(forEntityName: "UpdateTime", into: managedContext) as! UpdateTime
        
        time.time = currentDateTime
        
        do {
            try managedContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }

    private func removeUpdatetime() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let timeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UpdateTime")
        
        let times:[UpdateTime]
        do {
            times = try managedContext.fetch(timeFetch) as! [UpdateTime]
            
            for updateTime in times {
                managedContext.delete(updateTime)
                try! managedContext.save()
            }
            
        } catch {
            fatalError("Failed to fetch stations: \(error)")
        }
    }

}
