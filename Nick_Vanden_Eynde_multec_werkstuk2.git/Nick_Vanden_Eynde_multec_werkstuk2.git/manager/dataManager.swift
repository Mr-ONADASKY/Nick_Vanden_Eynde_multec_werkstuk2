//
//  dataManager.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse
    case InvalidJson
}


final class DataManager{
    
    typealias DataCompletion = ([AnyObject]?, DataManagerError?) -> ()
    
     func loadData(completion: @escaping DataCompletion) {
        
        let urlRequest = URLRequest(url: Configuration.url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            //check for errors
            guard error == nil && data != nil else {
                print("error calling GET")
                print(error!)
                completion(nil, DataManagerError.FailedRequest)
                return
            }
            self.parseDataToJson(data:data!, completion: completion)
        }
        task.resume()
    }
    
    private func parseDataToJson(data:Data, completion:DataCompletion){
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
                as? [AnyObject]
            
            if json != nil {
                completion(json, nil)

            } else {
                completion(nil, DataManagerError.InvalidJson)
            }
           /* for station in json!{
                
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            } */
            
    } catch let error as NSError {
            print(error)
            completion(nil, DataManagerError.InvalidJson)
        }
    }
}
