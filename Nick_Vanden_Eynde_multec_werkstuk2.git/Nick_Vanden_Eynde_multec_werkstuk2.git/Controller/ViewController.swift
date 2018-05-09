//
//  ViewController.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
// Bronnen: https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view
// https://benscheirman.com/2017/06/swift-json/
// https://stackoverflow.com/questions/9964371/how-to-detect-first-time-app-launch-on-an-iphone

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    

    @IBOutlet weak var myMapView: MKMapView!
    var locationManager = CLLocationManager()
    var villoStations = [Station]()
    private let dataBaseManager = DataBaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.villoStations = self.dataBaseManager.getDataFromTheDatabase()
        
        for villoStation in self.villoStations {
            let coordinate = CLLocationCoordinate2D(latitude: villoStation.latitude, longitude: villoStation.longitude)
            
            let annotation = MyAnnotation(coordinate: coordinate, title: villoStation.name)
            
            self.myMapView.addAnnotation(annotation)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let annotationTitle = view.annotation?.title
        {
            print(annotationTitle!)
        }
    }
}

