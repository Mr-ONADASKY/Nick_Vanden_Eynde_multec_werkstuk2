//
//  VilloStationDetailMapView.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 09/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import UIKit

protocol VilloStationDetailMapViewDelegate: class {
    func detailsRequestedForVilloStation(villoStation: VilloStationObject)
}

class VilloStationDetailMapView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var backGroundButton: UIButton!
    @IBOutlet weak var villoStationName: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var villoStationAdres: UILabel!
    @IBOutlet weak var villoStationAvailableBikes: UILabel!
    @IBOutlet weak var villoStationAvailableBikeStands: UILabel!
    @IBOutlet weak var adres: UILabel!
    @IBOutlet weak var availableBikes: UILabel!
    @IBOutlet weak var availableBikeStands: UILabel!
    
    var villoStation: VilloStationObject!
    weak var delegate: VilloStationDetailMapViewDelegate?
    
    
    @IBAction func seeDetails(_ sender: UIButton) {
        delegate?.detailsRequestedForVilloStation(villoStation: villoStation)
    }
    
    func configureWithVilloStation(villoStation: VilloStationObject) {
        self.villoStation = villoStation
        
        adres.text = NSLocalizedString("address", comment: "")
        availableBikes.text = NSLocalizedString("availableBikes", comment: "")
        availableBikeStands.text = NSLocalizedString("availableBikeStands", comment: "")
        
        villoStationName.text = villoStation.name
        villoStationAdres.text = String(villoStation.address)
        villoStationAvailableBikes.text = String(villoStation.available_bikes)
        villoStationAvailableBikeStands.text = String(villoStation.available_bike_stands)
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Check if it hit our annotation detail view components.
        
        // details button
        if let result = detailButton.hitTest(convert(point, to: detailButton), with: event) {
            return result
        }
        // fallback to our background content view
        return backGroundButton.hitTest(convert(point, to: backGroundButton), with: event)
    }
    
}
