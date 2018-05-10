//
//  VilloStationViewController.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 09/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import UIKit

class VilloStationViewController: UIViewController {

    var villoStation: VilloStationObject?
    
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var postion: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var banking: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var contractName: UILabel!
    @IBOutlet weak var availableBikeStands: UILabel!
    @IBOutlet weak var availableBikes: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var villoStationNumber: UILabel!
    @IBOutlet weak var villoStationName: UILabel!
    @IBOutlet weak var villoStationAddress: UILabel!
    @IBOutlet weak var villoStationLatitude: UILabel!
    @IBOutlet weak var villoStationLongitude: UILabel!
    @IBOutlet weak var villoStationBanking: UILabel!
    @IBOutlet weak var villoStationBonus: UILabel!
    @IBOutlet weak var villoStationStatus: UILabel!
    @IBOutlet weak var villoStationContractName: UILabel!
    @IBOutlet weak var villoStationAvailableBikeStands: UILabel!
    @IBOutlet weak var villoStationAvailableBikes: UILabel!
    @IBOutlet weak var villoStationLastUpdate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        number.text = NSLocalizedString("number", comment: "")
        name.text = NSLocalizedString("name", comment: "")
        address.text = NSLocalizedString("address", comment: "")
        postion.text = NSLocalizedString("postion", comment: "")
        latitude.text = NSLocalizedString("latitude", comment: "")
        longitude.text = NSLocalizedString("longitude", comment: "")
        banking.text = NSLocalizedString("banking", comment: "")
        bonus.text = NSLocalizedString("bonus", comment: "")
        status.text = NSLocalizedString("status", comment: "")
        contractName.text = NSLocalizedString("contractName", comment: "")
        availableBikeStands.text = NSLocalizedString("availableBikeStands", comment: "")
        lastUpdate.text = NSLocalizedString("lastUpdate", comment: "")
        
        
        if villoStation != nil {
            villoStationNumber.text = String(villoStation!.number)
            villoStationName.text = villoStation!.name
            villoStationAddress.text = villoStation!.address
            villoStationLatitude.text = String(villoStation!.position.latitude)
            villoStationLongitude.text = String(villoStation!.position.longitude)
            villoStationBanking.text = String(villoStation!.banking)
            villoStationBonus.text = String(villoStation!.bonus)
            villoStationStatus.text = String(villoStation!.status)
            villoStationContractName.text = String(villoStation!.contract_name)
            villoStationAvailableBikeStands.text = String(villoStation!.available_bike_stands)
            villoStationAvailableBikes.text = String(villoStation!.available_bikes)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "nl_BE POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600)
            villoStationLastUpdate.text = dateFormatter.string(from: Date(timeIntervalSince1970: villoStation!.last_update/1000))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
