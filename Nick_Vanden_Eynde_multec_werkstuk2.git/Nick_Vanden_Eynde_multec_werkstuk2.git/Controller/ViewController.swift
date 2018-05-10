//
//  ViewController.swift
//  Nick_Vanden_Eynde_multec_werkstuk2.git
//
//  Created by Nickvde on 05/05/2018.
//  Copyright © 2018 Nickvde. All rights reserved.
// Bronnen: https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view
// https://benscheirman.com/2017/06/swift-json/
// https://stacflow.com/questions/9964371/how-to-detect-first-time-app-launch-on-an-iphone
// https://digitalleaves.com/blog/2016/12/building-the-perfect-ios-map-ii-completely-custom-annotation-views/


import UIKit
import CoreLocation
import MapKit

private let kVilloStationName = "kVilloStationWishListAnnotationName"

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, VilloStationDetailMapViewDelegate{

    
    @IBOutlet weak var myMapView: MKMapView!
    
    var selectedVilloStation: VilloStationObject?
    var locationManager = CLLocationManager()
    //var villoStations = [Station]()
    private let dataBaseManager = DataBaseManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       configureVilloStationsInMap()
    }
    
    func configureVilloStationsInMap() {
        print(myMapView.annotations.count)
        var annotations = [MKAnnotation]()
        for VilloStation in VilloStationManager.sharedInstance.villoStations {
            let annotation = VilloStationAnnotation(villoStationObject: VilloStation)
            annotations.append(annotation)
            myMapView.addAnnotation(annotation)
        }
        print(myMapView.annotations.count)
        //myMapView.removeAnnotation(myMapView.annotations as! MKAnnotation)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pdvc = segue.destination as? VilloStationViewController {
            pdvc.villoStation = self.selectedVilloStation
        }
    }
    
    func detailsRequestedForVilloStation(villoStation: VilloStationObject) {
        self.selectedVilloStation = villoStation
        self.performSegue(withIdentifier: "villoStationDetails", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.villoStations = self.dataBaseManager.getDataFromTheDatabase()
        
        for villoStation in self.villoStations {
            let coordinate = CLLocationCoordinate2D(latitude: villoStation.latitude, longitude: villoStation.longitude)
            
            let annotation = MyAnnotation(coordinate: coordinate, title: villoStation.name)
            
            self.myMapView.addAnnotation(annotation)
            
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: kVilloStationName)
        
        if annotationView == nil {
            annotationView = VilloStationAnnotationView(annotation: annotation, reuseIdentifier: kVilloStationName)
            (annotationView as! VilloStationAnnotationView).villoStationDelegate = self
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}

