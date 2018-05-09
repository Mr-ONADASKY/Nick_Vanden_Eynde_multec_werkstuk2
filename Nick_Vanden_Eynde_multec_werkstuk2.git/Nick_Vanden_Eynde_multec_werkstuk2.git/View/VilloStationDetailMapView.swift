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
    
    @IBOutlet weak var villoStationName: UILabel!
    @IBOutlet weak var villoStationDetailLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var backGroundButton: UIButton!
    
    var villoStation: VilloStationObject!
    weak var delegate: VilloStationDetailMapViewDelegate?
    
    
    @IBAction func seeDetails(_ sender: UIButton) {
        delegate?.detailsRequestedForVilloStation(villoStation: villoStation)
    }
    
    func configureWithVilloStation(villoStation: VilloStationObject) {
        self.villoStation = villoStation
        
        villoStationName.text = villoStation.name
        villoStationDetailLabel.text = String(villoStation.available_bikes)
        
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
