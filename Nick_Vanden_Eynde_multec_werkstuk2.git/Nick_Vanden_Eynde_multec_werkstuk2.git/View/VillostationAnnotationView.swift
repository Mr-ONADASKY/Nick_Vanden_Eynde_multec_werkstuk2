//
//  VillostationAnnotationView.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 09/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
//

import Foundation
import MapKit

private let kVilloStationMapPinImage = UIImage(named: "bicyclePin")!
private let kVilloStationMapAnimationTime = 0.300

class VilloStationAnnotationView: MKAnnotationView {
    // data
    weak var villoStationDelegate: VilloStationDetailMapViewDelegate?
    weak var customCalloutView: VilloStationDetailMapView?
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    // MARK: - life cycle
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false // 1
        self.image = kVilloStationMapPinImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false // 1
        self.image = kVilloStationMapPinImage
    }
    
    // MARK: - callout showing and hiding
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected { // 2
            self.customCalloutView?.removeFromSuperview() // remove old custom callout (if any)
            
            if let newCustomCalloutView = loadVilloStationDetailMapView() {
                // fix location from top-left to its right place.
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height
                
                // set custom callout view
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView as! VilloStationDetailMapView as! VilloStationDetailMapView
                
                // animate presentation
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    UIView.animate(withDuration: kVilloStationMapAnimationTime, animations: {
                        self.customCalloutView!.alpha = 1.0
                    })
                }
            }
        } else { // 3
            if customCalloutView != nil {
                if animated { // fade out animation, then remove it.
                    UIView.animate(withDuration: kVilloStationMapAnimationTime, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() } // just remove it.
            }
        }
    }
    
    func loadPersonDetailMapView() -> UIView? { // 4
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 240, height: 280))
        return view
    }
    
    override func prepareForReuse() { // 5
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
    
    func loadVilloStationDetailMapView() -> VilloStationDetailMapView? {
        if let views = Bundle.main.loadNibNamed("VilloStationDetailMapView", owner: self, options: nil) as? [VilloStationDetailMapView],
            views.count > 0 {
            let villoStationDetailMapView = views.first!
            villoStationDetailMapView.delegate = views.first! as? VilloStationDetailMapViewDelegate
            villoStationDetailMapView.delegate = self.villoStationDelegate
            if let villoStationAnnotation = annotation as? VilloStationAnnotation {
                let villoStation = villoStationAnnotation.villoStationObject
                villoStationDetailMapView.configureWithVilloStation(villoStation: villoStation)
            }
            return villoStationDetailMapView
        }
            return nil
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // if super passed hit test, return the result
        if let parentHitView = super.hitTest(point, with: event) { return parentHitView }
        else { // test in our custom callout.
            if customCalloutView != nil {
                return customCalloutView!.hitTest(convert(point, to: customCalloutView!), with: event)
            } else { return nil }
        }
    }
}
