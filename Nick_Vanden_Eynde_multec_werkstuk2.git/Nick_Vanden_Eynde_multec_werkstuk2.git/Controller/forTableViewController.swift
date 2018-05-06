//
//  forTableViewController.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class forTableViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var villoStations = [Station]()
    
    private let dataManager = DataManager()
    private let dataBaseManager = DataBaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.villoStations = self.dataBaseManager.getDataFromTheDatabase()

        print(self.villoStations.count)
        
        self.tableview.reloadData()
        
       /*setupView()
        self.tableview.isHidden = false
        self.activityIndicator.stopAnimating()
        refreshVilloData()
 */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func refreshVilloData() {
        // fetch villo data
        
        dataManager.loadData() {stations,error in
            
            DispatchQueue.main.async {
                self.dataBaseManager.updateDatabase(stations: stations!)
                
                 self.villoStations = self.dataBaseManager.getDataFromTheDatabase()
                
                self.updateView()
                
            }
        }
    }
    
    private func updateView() {
        self.tableview.reloadData()
    }

    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView(){
        tableview.isHidden = true
        activityIndicator.startAnimating()
    }
}

    extension forTableViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(villoStations.count)
            return villoStations.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Dequeue Reusable Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let villoStation = villoStations[indexPath.row]
            
            cell.textLabel?.text = villoStation.name
            
            
            return cell
        }
}


