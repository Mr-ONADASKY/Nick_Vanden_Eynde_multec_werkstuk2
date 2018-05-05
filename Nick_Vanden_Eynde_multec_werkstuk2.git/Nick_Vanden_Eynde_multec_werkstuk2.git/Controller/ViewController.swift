//
//  ViewController.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = URL(string: "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlRequest = URLRequest(url: url!)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            //check for errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    as? [String: AnyObject]
                
                DispatchQueue.main.async {
                    
                    
                }
            } catch let error as NSError {
                print(error)
            }
            
        }
        task.resume()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

