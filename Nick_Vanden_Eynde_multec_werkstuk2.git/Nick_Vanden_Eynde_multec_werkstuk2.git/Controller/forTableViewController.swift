//
//  forTableViewController.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import UIKit

class forTableViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //let url = URL(string: "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale")
   // url = URL(string: "http://rest-service.guides.spring.io/greeting")
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupView()
        
        refreshVilloData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func refreshVilloData() {
        // fetch villo data
        
        loadData()
        
    }
    
    private func loadData() {
        //let url = URL(string: "http://api.nicehash.com/api?method=stats.provider&addr=14FMY9XHC3eCvdGBvQz3a3pCwAeoar8VRz")!
        /*URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            print(data.count) // you can parse your json data here
            }.resume()*/
        
        
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            //check for errors
            guard error == nil && data != nil else {
                print("error calling GET")
                print(error!)
                return
            }
            let decoder = JSONDecoder()
            
            struct pos: Codable {
                let userId: Int
                let id: Int
                let title: String
            }
            do {
                let posts = try decoder.decode(Array<pos>.self, from: data!)
            print(posts.count)
                print(posts.first?.title)
            } catch let error as NSError {
                print(error)
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    as? [String: AnyObject]
                //print(json?.count, json!["content"])
                print("hello", json)
                
                
                for station in json as! [Dictionary<String, Any>]{
                    print(station)
                    //print(station["number"])
                }
                
                DispatchQueue.main.async {
                    // let integer = json!["id"] as? NSNumber
                    // self.IdLabel.text = integer?.stringValue
                    // self.messageLabel.text = json?["content"] as? String
                    self.activityIndicator.stopAnimating()
                }
            } catch let error as NSError {
                print(error)
            }
            //self.parseDataToJson(data:data!)
        }
        task.resume()
    }
    
    private func parseDataToJson( data:Data){
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
                as? [String: AnyObject]
            print(json?.count)
            print("hello")
            
            
            for station in json as! [Dictionary<String, Any>]{
                print(station)
                print(station["number"])
            }
            
            DispatchQueue.main.async {
                // let integer = json!["id"] as? NSNumber
                // self.IdLabel.text = integer?.stringValue
                // self.messageLabel.text = json?["content"] as? String
                self.activityIndicator.stopAnimating()
            }
        } catch let error as NSError {
            print(error)
        }
    }

    private func setupView() {
        setupTableView()
        
    }
    
    private func setupTableView(){
        tableview.isHidden = true
        activityIndicator.startAnimating()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
