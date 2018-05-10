//
//  TableViewController.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
// Bronnen: https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view
// https://benscheirman.com/2017/06/swift-json/
// https://stackoverflow.com/questions/9964371/how-to-detect-first-time-app-launch-on-an-iphone

import UIKit
import CoreLocation

class TableViewController: UITableViewController {
    
    
    var villoStations = [Station]()
    
    private let dataManager = DataManager()
    private let dataBaseManager = DataBaseManager()
    
    @IBOutlet weak var updateLabel: UILabel!
    @IBAction func refresh(_ sender: UIRefreshControl) {
        
        dataManager.loadData() {
            (stations, error) in
            DispatchQueue.main.async {
                self.dataBaseManager.updateDatabase(stations: stations!)
                self.villoStations = self.dataBaseManager.getDataFromTheDatabase()
                self.tableView.reloadData()
                self.updateLabel.text = self.dataBaseManager.getUpdateTime()
                sender.endRefreshing()
            }
        }
        
    }
    //private let refreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.villoStations = self.dataBaseManager.getDataFromTheDatabase()
        updateLabel.text = self.dataBaseManager.getUpdateTime()

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
        tableView.reloadData()
    }
    
    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.isHidden = true
      //  activityIndicator.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.villoStations.count)
        return villoStations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        
        
        let villoStation = villoStations[indexPath.row]
        
        cell.textLabel?.text = villoStation.name

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! VilloStationViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        let villoStation = villoStations[(indexPath?.row)!];
        vc.villoStation = VilloStationObject(number: Int(villoStation.number), name: villoStation.name!, address: villoStation.address!, position: CLLocationCoordinate2D(latitude: villoStation.latitude, longitude: villoStation.longitude), banking: villoStation.banking, bonus: villoStation.bonus, status: villoStation.status!, contract_name: villoStation.contract_name!, bike_stands: Int(villoStation.bike_stands), available_bike_stands: Int(villoStation.available_bike_stands), available_bikes: Int(villoStation.available_bikes), last_update: villoStation.last_update)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
